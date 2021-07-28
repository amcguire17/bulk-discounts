require 'rails_helper'

RSpec.describe 'Admin Invoice show page' do
  before :each do
    @invoice_1 = create(:invoice)
    @item_1 = create(:item)
    @invoice_item_1 = InvoiceItem.create!(
      invoice: @invoice_1, item: @item_1, quantity: 1, status: 0
    )
  end

  it 'shows information regarding the invoice' do
    visit admin_invoice_path(@invoice_1)
    
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime(" %A, %B %e, %Y"))
    expect(page).to have_content(@invoice_1.customer.first_name)
    expect(page).to have_content(@invoice_1.customer.last_name)
  end

  it 'shows invoice items and item information' do
    visit admin_invoice_path(@invoice_1)

    # name
    expect(page).to have_content(@item_1.name)
    # Quantity
    expect(page).to have_content(@item_1.quantity)
    # Price
    expect(page).to have_content(@item_1.unit_price)
    # Status
    expect(page).to have_content(@item_1.status)
  end
  # When I visit an admin invoice show page
  # Then I see all of the items on the invoice including:
  # - Item name
  # - The quantity of the item ordered
  # - The price the Item sold for
  # - The Invoice Item status
end