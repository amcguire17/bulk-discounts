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
    describe '::incomplete_invoices' do
      it 'retrieves invoices with unshipped items, ordered by creation date' do
        customer = create(:customer)
        invoice_1 = create(:invoice, customer: customer, status: 0)
        invoice_2 = create(:invoice, customer: customer, status: 0)
        invoice_3 = create(:invoice, customer: customer, status: 0)
        invoice_4 = create(:invoice, customer: customer, status: 0)
        invoice_5 = create(:invoice, customer: customer, status: 0)
        inv_item_1 = create(:invoice_item, invoice: invoice_1, status: 2)
        inv_item_2 = create(:invoice_item, invoice: invoice_2, status: 2)
        inv_item_3 = create(:invoice_item, invoice: invoice_3, status: 2)
        inv_item_4 = create(:invoice_item, invoice: invoice_4, status: 0)
        inv_item_5 = create(:invoice_item, invoice: invoice_5, status: 1)
        invoice_list = [invoice_4, invoice_5]

        expect(Invoice.incomplete_invoices).to eq(invoice_list)
        expect(Invoice.incomplete_invoices[0]).to eq(invoice_4)
        expect(Invoice.incomplete_invoices[1]).to eq(invoice_5)
      end
    end

    describe '::merchants_invoices' do
      it 'returns all invoices for a specific merchant' do
        merchant_1 = create(:merchant)
        merchant_2 = create(:merchant)

        customer_1 = create(:customer)
        customer_2 = create(:customer)

        item_1 = create(:item, merchant_id: merchant_1.id)
        item_2 = create(:item, merchant_id: merchant_1.id)
        item_3 = create(:item, merchant_id: merchant_2.id)

        invoice_1 = create(:invoice, customer_id: customer_1.id)
        invoice_2 = create(:invoice, customer_id: customer_1.id)
        invoice_3 = create(:invoice, customer_id: customer_2.id)
        invoice_4 = create(:invoice, customer_id: customer_2.id)

        invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)
        invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id)
        invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_2.id)
        invoice_item_4 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_3.id)
        invoice_item_5 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_3.id)
        invoice_item_6 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_4.id)

        expect(Invoice.merchants_invoices(merchant_1.id)).to eq([invoice_1, invoice_2, invoice_3])
      end
    end
  end

  describe 'instance methods' do
    describe '#total_revenue' do
      it 'calculates total revenue for invoice' do
        invoice = create(:invoice)
        item1 = create(:item)
        item2 = create(:item)
        invoice_item1 = InvoiceItem.create!(
          invoice: invoice,
          item: item1,
          quantity: 1,
          unit_price: 100,
          status: 0
        )
        invoice_item2 = InvoiceItem.create!(
          invoice: invoice,
          item: item2,
          quantity: 1,
          unit_price: 100,
          status: 0
        )
        expect(invoice.total_revenue).to eq(2)
      end
    end
    describe '#total_discounted_revenue' do
      it 'calculates total discounted revenue for invoice' do
        merchant = create(:merchant)
        invoice = create(:invoice)
        item1 = create(:item, merchant: merchant)
        item2 = create(:item, merchant: merchant)
        invoice_item1 = InvoiceItem.create!(
          invoice: invoice,
          item: item1,
          quantity: 5,
          unit_price: 1000,
          status: 0
        )
        invoice_item2 = InvoiceItem.create!(
          invoice: invoice,
          item: item2,
          quantity: 1,
          unit_price: 1500,
          status: 0
        )
        bulk_discount = merchant.bulk_discounts.create!(quantity: 5, percentage: 15)
        expect(invoice.total_discounted_revenue).to eq(57.50)
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
