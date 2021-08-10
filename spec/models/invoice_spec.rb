require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:invoice_items) }
    it { should have_many(:transactions) }
    it { should have_many(:items).through(:invoice_items) }
  end
  describe 'validations' do
    it { should validate_presence_of(:status) }
  end
  describe 'class methods' do
    describe '.incomplete_invoices' do
      it 'retrieves invoices with unshipped items, ordered by creation date' do
        customer = create(:customer)
        invoice_1, invoice_2, invoice_3, invoice_4, invoice_5 = create_list(:invoice, 5, customer: customer, status: 0)
        inv_item_1 = create(:invoice_item, invoice: invoice_1, status: 2)
        inv_item_2 = create(:invoice_item, invoice: invoice_2, status: 2)
        inv_item_3 = create(:invoice_item, invoice: invoice_3, status: 2)
        inv_item_4 = create(:invoice_item, invoice: invoice_4, status: 0)
        inv_item_5 = create(:invoice_item, invoice: invoice_5, status: 1)

        expect(Invoice.incomplete_invoices).to eq([invoice_4, invoice_5])
      end
    end
    describe '.merchants_invoices' do
      it 'returns all invoices for a specific merchant' do
        merchant_1, merchant_2 = create_list(:merchant, 2)
        customer_1, customer_2 = create_list(:customer, 2)
        item_1, item_2 = create_list(:item, 2, merchant: merchant_1)
        item_3 = create(:item, merchant: merchant_2)
        invoice_1, invoice_2 = create_list(:invoice, 2, customer: customer_1)
        invoice_3, invoice_4 = create_list(:invoice, 2, customer: customer_2)
        invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1)
        invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice_2)
        invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice_2)
        invoice_item_4 = create(:invoice_item, item: item_1, invoice: invoice_3)
        invoice_item_5 = create(:invoice_item, item: item_2, invoice: invoice_3)
        invoice_item_6 = create(:invoice_item, item: item_3, invoice: invoice_4)

        expect(Invoice.merchants_invoices(merchant_1.id)).to eq([invoice_1, invoice_2, invoice_3])
      end
    end
  end
  describe 'instance methods' do
    before :each do
      @merchant = create(:merchant)
      @invoice = create(:invoice)
      @item_1, @item_2 = create_list(:item, 2, merchant: @merchant)
      @invoice_item1 = InvoiceItem.create!(invoice: @invoice, item: @item_1, quantity: 5, unit_price: 1000, status: 0)
      @invoice_item2 = InvoiceItem.create!(invoice: @invoice, item: @item_2, quantity: 1, unit_price: 1500, status: 0)
    end
    describe '#total_revenue' do
      it 'calculates total revenue for invoice' do
        expect(@invoice.total_revenue).to eq(65)
      end
    end
    describe '#total_discounted_revenue' do
      it 'calculates total discounted revenue for invoice' do
        bulk_discount = @merchant.bulk_discounts.create!(name: '5% Discount', quantity: 5, percentage: 15)
        expect(@invoice.total_discounted_revenue).to eq(57.50)
      end
    end
    describe '#created_at_display' do
      it 'displays creation time in simple format' do
        invoice = create(:invoice, created_at: 'Wed, 28 Jul 2021 21:49:20 UTC +00:00')
        expect(invoice.created_at_display).to eq('Wednesday, July 28, 2021')
      end
    end
  end
end
