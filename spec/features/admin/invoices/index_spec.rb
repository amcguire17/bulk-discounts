require 'rails_helper'

RSpec.describe 'Admin Invoices index page' do
  before :each do
    @invoice_1 = create(:invoice)
  end
  it 'shows a list of all invoice ids in the system' do
    visit admin_invoices_path
    expect(page).to have_content("#{@invoice_1.id}")
  end
  it 'links each id to invoice show page' do
    visit admin_invoices_path
    click_link "#{@invoice_1.id}"
    expect(current_path).to eq(admin_invoice_path(@invoice_1))
  end
end
