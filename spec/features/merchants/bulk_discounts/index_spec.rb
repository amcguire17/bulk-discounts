require 'rails_helper'

RSpec.describe 'Discount Index Page' do
  before :each do
    @merchant = create(:merchant)
    @discount_1 = @merchant.bulk_discounts.create(name: '50% Discount', percentage: 50, quantity: 75)
    @discount_2 = @merchant.bulk_discounts.create(name: '25% Discount', percentage: 25, quantity: 40)
    @discount_3 = @merchant.bulk_discounts.create(name: '10% Discount', percentage: 10, quantity: 15)

    visit merchant_bulk_discounts_path(@merchant)
  end
  describe 'information and links' do
    it 'lists all of bulk discounts and attributes' do
      within("#discount-#{@discount_1.id}") do
        expect(page).to have_content(@discount_1.name)
        expect(page).to have_content(@discount_1.percentage)
        expect(page).to have_content(@discount_1.quantity)
      end
      within("#discount-#{@discount_2.id}") do
        expect(page).to have_content(@discount_2.name)
        expect(page).to have_content(@discount_2.percentage)
        expect(page).to have_content(@discount_2.quantity)
      end
      within("#discount-#{@discount_3.id}") do
        expect(page).to have_content(@discount_3.name)
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
  describe 'holiday section' do
    before :each do
      @holiday_info = NagerDateService.next_three_holidays
    end
    it 'lists the next 3 upcoming holidays' do
      expect(page).to have_content(@holiday_info[0].name)
      expect(page).to have_content(@holiday_info[0].date)
      expect(page).to have_content(@holiday_info[1].name)
      expect(page).to have_content(@holiday_info[1].date)
      expect(page).to have_content(@holiday_info[2].name)
      expect(page).to have_content(@holiday_info[2].date)
    end

    it 'has link to add a discount to holiday' do
      expect(page).to have_button("Create #{@holiday_info[0].name} Discount")
      expect(page).to have_button("Create #{@holiday_info[1].name} Discount")
      expect(page).to have_button("Create #{@holiday_info[2].name} Discount")

      click_button "Create #{@holiday_info[0].name} Discount"
      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
    end

    it 'form has prepopulated fields with holiday name and attributes' do
      click_button "Create #{@holiday_info[0].name} Discount"
      expect(page).to have_field(:bulk_discount_name, with: 'Labour Day Discount')
      expect(page).to have_field(:bulk_discount_quantity, with: 2)
      expect(page).to have_field(:bulk_discount_percentage, with: "30%")

      visit merchant_bulk_discounts_path(@merchant)
      click_button "Create #{@holiday_info[0].name} Discount"
      expect(page).to have_field(:bulk_discount_name, with: 'Labour Day Discount')
      expect(page).to have_field(:bulk_discount_quantity, with: 2)
      expect(page).to have_field(:bulk_discount_percentage, with: "30%")

      visit merchant_bulk_discounts_path(@merchant)
      click_button "Create #{@holiday_info[0].name} Discount"
      expect(page).to have_field(:bulk_discount_name, with: 'Labour Day Discount')
      expect(page).to have_field(:bulk_discount_quantity, with: 2)
      expect(page).to have_field(:bulk_discount_percentage, with: "30%")
    end

    it 'can update form information and save new holiday discount' do
      click_button "Create #{@holiday_info[0].name} Discount"
      fill_in(:bulk_discount_quantity, with: 10)
      fill_in(:bulk_discount_percentage, with: 30)
      click_button 'Create Holiday Discount'
      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
      expect(page).to have_content('Labour Day Discount')
      expect(page).to have_content('Percentage Discount: 30%')
      expect(page).to have_content('Quantity Threshold: 10')
    end
  end
end
