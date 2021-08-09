require 'rails_helper'

RSpec.describe 'Merchant Invoices index page' do
  it 'see all of the invoices that include at least one of my merchants items' do
    merchant = create(:merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    item_1, item_2, item_3 = create_list(:item, 3, merchant: merchant)
    invoice_1, invoice_2 = create_list(:invoice, 2, customer: customer_1)
    invoice_3 = create(:invoice, customer: customer_2)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1)
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2)
    invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_3)

    visit merchant_invoices_path(merchant)

    expect(page).to have_content(invoice_1.id)
    expect(page).to have_link("Invoice ##{invoice_1.id}")
    expect(page).to have_content(invoice_2.id)
    expect(page).to have_link("Invoice ##{invoice_2.id}")
    expect(page).to have_content(invoice_3.id)
    expect(page).to have_link("Invoice ##{invoice_3.id}")
  end
end
