require 'rails_helper'

RSpec.describe 'Delete Discount' do
  before :each do
    @merchant = create(:merchant)
    @discount_1 = @merchant.bulk_discounts.create(name: '50% Discount', percentage: 50, quantity: 75)
    @discount_2 = @merchant.bulk_discounts.create(name: '25% Discount', percentage: 25, quantity: 40)
    @discount_3 = @merchant.bulk_discounts.create(name: '10% Discount', percentage: 10, quantity: 15)

    visit merchant_bulk_discounts_path(@merchant)
  end
  it 'has link to delete discount' do
    within("#discount-#{@discount_1.id}") do
      expect(page).to have_link('Delete Discount')
    end
    within("#discount-#{@discount_2.id}") do
      expect(page).to have_link('Delete Discount')
    end
    within("#discount-#{@discount_3.id}") do
      expect(page).to have_link('Delete Discount')
    end
  end
  it 'can delete discount by clicking link' do
    within("#discount-#{@discount_3.id}") do
      click_link 'Delete Discount'
    end
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
    expect(page).to_not have_content("Quantity Threshold: #{@discount_3.quantity}")
    expect(page).to_not have_content("Percentage Discount: #{@discount_3.percentage}")
  end
end
