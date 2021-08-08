require 'rails_helper'

RSpec.describe 'New Bulk Discount' do
  before :each do
    @merchant = create(:merchant)
    visit merchant_bulk_discounts_path(@merchant)
  end
  it 'has link to add new bulk discount' do
    expect(page).to have_link('New Discount')
    click_link 'New Discount'
    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
  end
  it 'has form to fill out information for new discount and is redirected to index page' do
    click_link 'New Discount'
    fill_in(:bulk_discount_quantity, with: 15)
    fill_in(:bulk_discount_percentage, with: 25)
    click_button('Create Discount')

    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
    expect(page).to have_content(15)
    expect(page).to have_content('25%')
  end
  it 'returns an error when informtion is not filled out correctly' do
    click_link 'New Discount'
    fill_in(:bulk_discount_quantity, with: '')
    fill_in(:bulk_discount_percentage, with: 125)
    click_button('Create Discount')

    expect(page).to have_current_path(new_merchant_bulk_discount_path(@merchant))
    expect(page).to have_content("Error: Percentage must be less than 100, Quantity is not a number")
  end
end
