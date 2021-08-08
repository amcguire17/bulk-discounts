require 'rails_helper'

RSpec.describe 'Merchant Invoices show page' do
  before :each do
    @merchant = create(:merchant)

    @customer = create(:customer)

    @invoice = create(:invoice, customer: @customer)

    @item_1 = create(:item, merchant: @merchant)
    @item_2 = create(:item, merchant: @merchant)

    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice, status: 1)
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice, status: 1)

    @bulk_discounts = @merchant.bulk_discounts.create!(quantity: 5, percentage: 15)

    visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end

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

  it "displays the total revenue from all items on the invoice" do
    expect(page).to have_content("Total revenue from invoice: #{@invoice.total_revenue}")
  end

  it "displays the total discounted revenue from all items on the invoice" do
    expect(page).to have_content("Total discounted revenue from invoice: #{@invoice.total_discounted_revenue}")
  end

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
