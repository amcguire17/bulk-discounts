require 'rails_helper'

RSpec.describe 'Discount Index Page' do
  before :each do
    @merchant = create(:merchant)
    @discount_1 = @merchant.bulk_discounts.create(name: '50% Discount', percentage: 50, quantity: 75)
    @discount_2 = @merchant.bulk_discounts.create(name: '25% Discount', percentage: 25, quantity: 40)
    @discount_3 = @merchant.bulk_discounts.create(name: '10% Discount', percentage: 10, quantity: 15)

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
  it 'lists the next 3 upcoming holidays' do
    holiday_info = [{:date=>"2021-09-06", :name=>"Labour Day"}, {date: "2021-10-11", name: "Columbus Day"}, {date: "2021-11-11", name: "Veterans Day"}]
    allow(NagerDateService).to receive(:next_three_holidays).and_return(holiday_info)

    expect(page).to have_content(holiday_info[0][:name])
    expect(page).to have_content(holiday_info[0][:date])
    expect(page).to have_content(holiday_info[1][:name])
    expect(page).to have_content(holiday_info[1][:date])
    expect(page).to have_content(holiday_info[2][:name])
    expect(page).to have_content(holiday_info[2][:date])
  end
end
