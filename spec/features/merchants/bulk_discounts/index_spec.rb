require 'rails_helper'

RSpec.describe 'Discount Index Page' do
  before :each do
    @merchant = create(:merchant)
    @discount_1 = @merchant.bulk_discounts.create(percentage: 50, quantity: 75)
    @discount_2 = @merchant.bulk_discounts.create(percentage: 25, quantity: 40)
    @discount_3 = @merchant.bulk_discounts.create(percentage: 10, quantity: 15)

    visit merchant_bulk_discounts_path(@merchant)
  end
  it 'lists all of bulk discounts and attributes' do
    within("#discount-#{@discount_1.id}") do
      expect(page).to have_content(@discount_1.percentage)
      expect(page).to have_content(@discount_1.quantity)
    end
    within("#discount-#{@discount_2.id}") do
      expect(page).to have_content(@discount_2.percentage)
      expect(page).to have_content(@discount_2.quantity)
    end
    within("#discount-#{@discount_3.id}") do
      expect(page).to have_content(@discount_3.percentage)
      expect(page).to have_content(@discount_3.quantity)
    end
  end
  it 'links to each discounts show page' do
    within("#discount-#{@discount_1.id}") do
      expect(page).to have_link('Discount Page')
      click_link 'Discount Page'
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @discount_1))
    end
    visit merchant_bulk_discounts_path(@merchant)

    within("#discount-#{@discount_2.id}") do
      expect(page).to have_link('Discount Page')
      click_link 'Discount Page'
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @discount_2))
    end
    visit merchant_bulk_discounts_path(@merchant)

    within("#discount-#{@discount_3.id}") do
      expect(page).to have_link('Discount Page')
      click_link 'Discount Page'
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @discount_3))
    end
  end
end
