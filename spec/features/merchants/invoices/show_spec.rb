require 'rails_helper'

RSpec.describe 'Merchant Invoices show page' do
  before :each do
    @merchant = create(:merchant)
    @customer = create(:customer)
    @invoice = create(:invoice, customer: @customer)
    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)
    @invoice_item_1 = create(:invoice_item, quantity: 5, item: @item_1, invoice: @invoice, status: 1)
    @invoice_item_2 = create(:invoice_item, quantity: 3, item: @item_2, invoice: @invoice, status: 1)
    @bulk_discount = @merchant.bulk_discounts.create!(name: '15% Discount', quantity: 5, percentage: 15)

    visit merchant_invoice_path(@merchant, @invoice)
  end
  describe 'display information' do
    it 'can see all of that merchants invoice info' do
      expect(page).to have_content("Invoice ##{@invoice.id}")
      expect(page).to have_content("Status: #{@invoice.status}")
      expect(page).to have_content("Created On: #{@invoice.created_at.strftime('%A, %B %d, %Y')}")
      expect(page).to have_content(@customer.first_name)
      expect(page).to have_content(@customer.last_name)
    end
    it "displays the invoice item information such as the item name, quantity ordered, price of item, invoice item status" do
      within "#invoice_item-info-#{@invoice_item_1.id}" do
        expect(page).to have_content("Invoice item name: #{@item_1.name}")
        expect(page).to have_content("Invoice item quantity: #{@invoice_item_1.quantity}")
        expect(page).to have_content("Invoice item price: #{@invoice_item_1.unit_price}")
        expect(page).to have_content("Invoice item status: #{@invoice_item_1.status}")
      end

      within "#invoice_item-info-#{@invoice_item_2.id}" do
        expect(page).to have_content("Invoice item name: #{@item_2.name}")
        expect(page).to have_content("Invoice item quantity: #{@invoice_item_2.quantity}")
        expect(page).to have_content("Invoice item price: #{@invoice_item_2.unit_price}")
        expect(page).to have_content("Invoice item status: #{@invoice_item_2.status}")
      end
    end
  end
  describe 'status update' do
    it 'can click on the select status for an item and update it to a new status' do
      within "#invoice_item-info-#{@invoice_item_1.id}" do
        expect(page).to have_content("Invoice item status: #{@invoice_item_1.status}")
        expect(page).to have_select(:status, selected: 'packaged')
        expect(page).to have_select(:status, :options => ['pending', 'packaged', 'shipped'])
        select('shipped', from: 'status')
        click_on('Update Item Status')
        expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice.id}")
        expect(page).to have_select(:status, selected: 'shipped')
      end
    end
  end
  describe 'revenue' do
    it "displays the total revenue from all items on the invoice" do
      expect(page).to have_content("Total revenue from invoice: $#{@invoice.total_revenue.round(2)}")
    end
    it "displays the total discounted revenue from all items on the invoice" do
      expect(page).to have_content("Total discounted revenue from invoice: $#{@invoice.total_discounted_revenue.round(2)}")
    end
    it 'links to invoice item discount if one has been applied' do
      within("#invoice_item-info-#{@invoice_item_1.id}") do
        expect(page).to have_link('Discount Applied')
        click_link 'Discount Applied'
        expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @bulk_discount))
      end

      visit merchant_invoice_path(@merchant, @invoice)
      within("#invoice_item-info-#{@invoice_item_2.id}") do
        expect(page).to_not have_link('Discount Applied')
      end
    end
  end
end
