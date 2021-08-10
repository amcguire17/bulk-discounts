require 'rails_helper'

RSpec.describe 'Discount Show Page' do
  before :each do
    @merchant = create(:merchant)
    @discount = @merchant.bulk_discounts.create(name: '50% Discount', percentage: 50, quantity: 75)
    visit merchant_bulk_discount_path(@merchant, @discount)
  end
  it 'shows discount attributes' do
    expect(page).to have_content(@discount.quantity)
    expect(page).to have_content(@discount.percentage)
  end
end
