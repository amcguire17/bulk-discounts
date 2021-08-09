require 'rails_helper'

RSpec.describe 'admin merchants index page' do
  before :each do
    @merchant_1, @merchant_3 = create_list(:merchant, 2, status: 'enabled')
    @merchant_2, @merchant_4 = create_list(:merchant, 2)
    visit admin_merchants_path
  end
  describe 'merchant display' do
    it 'shows all of the merchants' do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
      expect(page).to have_content(@merchant_4.name)
    end
    it 'shows a button to endable merchant with disabled status and update status' do
      within ("#merchant-#{@merchant_2.id}") do
        click_button('Enable')
      end

      expect(current_path).to eq(admin_merchants_path)

      within ("#merchant-#{@merchant_2.id}") do
        expect(page).to_not have_button('Enable')
        expect(page).to have_button('Disable')
      end
    end
    it 'displays a button to disable merchant with enabled status and update status' do
      within ("#merchant-#{@merchant_1.id}") do
        click_button('Disable')
      end

      expect(current_path).to eq(admin_merchants_path)

      within ("#merchant-#{@merchant_1.id}") do
        expect(page).to_not have_button('Disable')
        expect(page).to have_button('Enable')
      end
    end
    it 'groups merchants by status' do
      within ("#enabled") do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_3.name)
      end

      within ("#disabled") do
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_4.name)
      end
    end
  end
  describe 'top revenue earners' do
    before :each do
      @merchant_5 = create(:merchant, status: 'enabled')
      @merchant_6, @merchant_7 = create_list(:merchant, 2)

      @item_1, @item_2 = create_list(:item, 2, merchant: @merchant_1)
      @item_3, @item_4 = create_list(:item, 2, merchant: @merchant_3)
      @item_5, @item_6 = create_list(:item, 2, merchant: @merchant_4)
      @item_7, @item_8 = create_list(:item, 2, merchant: @merchant_5)
      @item_9 = create(:item, merchant: @merchant_6)
      @item_10 = create(:item, merchant: @merchant_7)

      @invoice_1 = create(:invoice, status: 'completed', created_at: '2019-06-24 21:54:10 UTC')
      @invoice_2 = create(:invoice, status: 'completed', created_at: '2019-07-24 21:54:10 UTC')
      @invoice_3 = create(:invoice, status: 'completed', created_at: '2019-08-24 21:54:10 UTC')
      @invoice_4 = create(:invoice, status: 'completed', created_at: '2019-11-24 21:54:10 UTC')
      @invoice_5 = create(:invoice, status: 'completed', created_at: '2019-01-24 21:54:10 UTC')
      @invoice_6 = create(:invoice, status: 'completed', created_at: '2019-07-24 21:54:10 UTC')

      Invoice.all.each do |invoice|
        create(:transaction, invoice: invoice)
      end

      @invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 12000, item: @item_1, invoice: @invoice_1)
      @invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 10100, item: @item_2, invoice: @invoice_1)
      @invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 20000, item: @item_10, invoice: @invoice_2)
      @invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 15000, item: @item_4, invoice: @invoice_3)
      @invoice_item_1 = create(:invoice_item, quantity: 3, unit_price: 15000, item: @item_3, invoice: @invoice_4)
      @invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 9000, item: @item_5, invoice: @invoice_5)
      @invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 23000, item: @item_9, invoice: @invoice_6)
      visit admin_merchants_path
    end
    it 'displays top five merchants by revenue' do
      within ("#top_revenue") do
        expect(@merchant_3.name).to appear_before(@merchant_1.name)
        expect(@merchant_7.name).to_not appear_before(@merchant_6.name)
        expect(@merchant_1.name).to appear_before(@merchant_4.name)
        expect(page).to_not have_content(@merchant_2.name)
      end

      within ("#top_revenue") do
        expect(page).to have_content("#{@merchant_1.name} - $221.0 in sales")
        expect(page).to have_content("#{@merchant_3.name} - $750.0 in sales")
        expect(page).to have_content("#{@merchant_4.name} - $90.0 in sales")
      end
    end
    it 'dispalys the top merchants best revenue day' do
      within ("#top_revenue") do
        expect(page).to have_content("Top day for #{@merchant_1.name} was 06/24/19")
        expect(page).to have_content("Top day for #{@merchant_3.name} was 11/24/19")
        expect(page).to have_content("Top day for #{@merchant_4.name} was 01/24/19")
        expect(page).to have_content("Top day for #{@merchant_6.name} was 07/24/19")
      end
    end
  end
end
