require 'rails_helper'

RSpec.describe 'Edit Discount Page' do
  before :each do
    @merchant = create(:merchant)
    @discount = @merchant.bulk_discounts.create!(quantity: 20, percentage: 20)
    visit edit_merchant_bulk_discount_path(@merchant, @discount)
  end
  it 'has previous information on form to edit' do
    expect(page).to have_field(:bulk_discount_quantity, with: 20)
    expect(page).to have_field(:bulk_discount_percentage, with: "20%")
  end
  it 'can enter new information and submit to be redirected to merchant item page and see update notice' do
    fill_in(:bulk_discount_quantity, with: 10)
    fill_in(:bulk_discount_percentage, with: 15)
    click_button('Update Discount')

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @discount))
    expect(page).to have_content(10)
    expect(page).to have_content(15)
  end
  it 'returns an error when informtion is not filled out correctly' do
    fill_in(:bulk_discount_quantity, with: 20)
    fill_in(:bulk_discount_percentage, with: 115)
    click_button('Update Discount')

    expect(page).to have_current_path(edit_merchant_bulk_discount_path(@merchant, @discount))
    expect(page).to have_content("Error: Percentage must be less than 100")
  end
end
