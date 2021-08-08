class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.bulk_discounts.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.new(discount_params)
    if discount.save
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      redirect_to new_merchant_bulk_discount_path(merchant)
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.bulk_discounts.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.find(params[:id])
    if discount.update(discount_params)
      redirect_to merchant_bulk_discount_path(merchant, discount)
    else
      redirect_to edit_merchant_bulk_discount_path(merchant, discount)
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
  end

  def destroy

  end
  private
  def discount_params
    params.require(:bulk_discount).permit(:quantity, :percentage)
  end
end
