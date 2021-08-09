require 'rails_helper'

RSpec.describe 'Admin Deshboard Page' do
  before :each do
    @customer = create(:customer)
    @invoice_1, @invoice_2, @invoice_3 = create_list(:invoice, 3, customer: @customer, status: 0)
    @invoice_4 = create(:invoice, customer: @customer, status: 0, created_at: '2019-06-24 21:54:10 UTC')
    @invoice_5 = create(:invoice, customer: @customer, status: 0, created_at: '2019-06-25 21:54:11 UTC')
    @inv_item_1 = create(:invoice_item, invoice: @invoice_1, status: 2)
    @inv_item_2 = create(:invoice_item, invoice: @invoice_2, status: 2)
    @inv_item_3 = create(:invoice_item, invoice: @invoice_3, status: 2)
    @inv_item_4 = create(:invoice_item, invoice: @invoice_4, status: 0)
    @inv_item_5 = create(:invoice_item, invoice: @invoice_5, status: 1)

    visit admin_index_path
  end
  describe 'header and navigation' do
    it 'displays admin dashboard header' do
      expect(page).to have_content('Admin Dashboard')
    end
    it 'shows links to admin merchants and invocies index' do
      expect(page).to have_content('Merchants')
      click_link 'Merchants'
      expect(current_path).to eq(admin_merchants_path)

      visit admin_index_path
      expect(page).to have_content('Invoices')
      click_link 'Invoices'
      expect(current_path).to eq(admin_invoices_path)
    end
  end
  describe 'top customers' do
    it 'shows top 5 customer names along with successful transactions' do
      customer_1, customer_2, customer_3, customer_4, customer_5, customer_6 = create_list(:customer, 6)

      Customer.all.each do |customer|
        create_list(:invoice, 1, customer: customer)
      end

      create_list(:transaction, 2, result: 'failed', invoice: customer_1.invoices.first)
      create_list(:transaction, 2, result: 'success', invoice: customer_2.invoices.first)
      create_list(:transaction, 3, result: 'success', invoice: customer_3.invoices.first)
      create_list(:transaction, 4, result: 'success', invoice: customer_4.invoices.first)
      create_list(:transaction, 5, result: 'success', invoice: customer_5.invoices.first)
      create_list(:transaction, 6, result: 'success', invoice: customer_6.invoices.first)

      visit admin_index_path
      expect(page).to have_content("Top 5 Customers")
      within("#top_five") do
        expect(customer_6.first_name).to appear_before(customer_5.first_name)
        expect(page).to_not have_content(customer_1.first_name)
      end
    end
  end
  describe 'incomplete invoices' do
    it 'displays incomplete invoices' do
      expect(page).to have_content('Incomplete Invoices')
      within("#incomplete_invoices") do
        expect(page).to_not have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_4.id)
        expect(page).to have_content(@invoice_5.id)
      end
    end
    it 'links to invoice show pages through their IDs' do
      within("#incomplete_invoices") do
        click_link "#{@invoice_4.id}"
      end
      expect(current_path).to eq(admin_invoice_path(@invoice_4))
    end
    it 'displays creation dates of invoices ordered oldest to newest' do
      within("#incomplete_invoices") do
        expect(@invoice_4.display_date).to appear_before(@invoice_5.display_date)
      end
    end
  end
end
