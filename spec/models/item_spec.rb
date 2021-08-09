require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end
  before :each do
    @item_1 = create(:item, status: 'enabled')
    @item_2, @item_3 = create_list(:item, 2)
  end
  describe 'class methods' do
    describe '.status_enabled' do
      it 'returns all items with status enabled' do
        expect(Item.status_enabled).to eq([@item_1])
      end
    end
    describe '.status_disabled' do
      it 'returns all items with status disabled' do
        expect(Item.status_disabled).to eq([@item_2, @item_3])
      end
    end
    describe '.ready_to_ship' do
      it 'returns all items with invoice status pending' do
        customer = create(:customer)
        invoice_1, invoice_2, invoice_3, invoice_5, invoice_6, invoice_7 = create_list(:invoice, 6, customer: customer, status: 'in progress')
        invoice_4 = create(:invoice, customer: customer, status: :cancelled)
        invoice_8 = create(:invoice, customer: customer, status: :completed)
        transaction_1 = create(:transaction, invoice: invoice_1)
        transaction_2 = create(:transaction, invoice: invoice_2)
        transaction_3 = create(:transaction, invoice: invoice_3)
        transaction_4 = create(:transaction, invoice: invoice_4, result: 'failed')
        transaction_5 = create(:transaction, invoice: invoice_5)
        transaction_6 = create(:transaction, invoice: invoice_6, result: 'failed')
        transaction_7 = create(:transaction, invoice: invoice_7)
        transaction_8 = create(:transaction, invoice: invoice_8)
        invoice_item_1 = create(:invoice_item, item: @item_1, invoice: invoice_1, status: :packaged)
        invoice_item_2 = create(:invoice_item, item: @item_2, invoice: invoice_2, status: :packaged)
        invoice_item_3 = create(:invoice_item, item: @item_3, invoice: invoice_3, status: :packaged)
        invoice_item_4 = create(:invoice_item, item: @item_1, invoice: invoice_4, status: :packaged)
        invoice_item_5 = create(:invoice_item, item: @item_2, invoice: invoice_5, status: :packaged)
        invoice_item_6 = create(:invoice_item, item: @item_3, invoice: invoice_6, status: :packaged)
        invoice_item_7 = create(:invoice_item, item: @item_1, invoice: invoice_7, status: :packaged)
        invoice_item_8 = create(:invoice_item, item: @item_2, invoice: invoice_8, status: :shipped)

        expect(Item.ready_to_ship).to eq([@item_1, @item_2, @item_3, @item_2, @item_1])
      end
    end
    describe '.popular_items' do
      it 'returns top 5 items by revenue' do
        customer = create(:customer)
        invoice_1, invoice_2 = create_list(:invoice, 2, customer: customer, status: 'completed')
        item_4, item_5, item_6 = create_list(:item, 3)
        invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: @item_1, quantity: 1, unit_price: 5000)
        invoice_item_2 = create(:invoice_item, invoice: invoice_1, item: @item_2, quantity: 1, unit_price: 2000)
        invoice_item_3 = create(:invoice_item, invoice: invoice_1, item: @item_3, quantity: 1, unit_price: 9000)
        invoice_item_4 = create(:invoice_item, invoice: invoice_1, item: item_4, quantity: 1, unit_price: 4000)
        invoice_item_5 = create(:invoice_item, invoice: invoice_2, item: item_5, quantity: 1, unit_price: 1000)
        invoice_item_6 = create(:invoice_item, invoice: invoice_2, item: item_6, quantity: 1, unit_price: 3000)
        transaction_1 = create(:transaction, result: 'success', invoice: invoice_1)
        transaction_2 = create(:transaction, result: 'success', invoice: invoice_2)

        expect(Item.popular_items).to eq([@item_3, @item_1, item_4, item_6, @item_2])
      end
    end
    describe '.item_top_day' do
      it 'returns top date of sales for item' do
        customer = create(:customer)
        invoice_1 = create(:invoice, customer: customer, status: 'completed', created_at: '2021-03-06 21:54:10 UTC')
        invoice_2 = create(:invoice, customer: customer, status: 'completed')
        invoice_item_1 = create(:invoice_item, invoice: invoice_1, item: @item_1, quantity: 2, unit_price: 5000)
        invoice_item_2 = create(:invoice_item, invoice: invoice_2, item: @item_1, quantity: 1, unit_price: 2000)
        transaction_1 = create(:transaction, result: 'success', invoice: invoice_1)
        transaction_2 = create(:transaction, result: 'success', invoice: invoice_2)

        expect(Item.item_top_day(@item_1.id)).to eq(Time.parse('2021-03-06 21:54:10 UTC'))
      end
    end
  end
  describe 'instance methods' do
    describe '#unit_price_dollars' do
      it 'converts unit price to dollars' do
        item = create(:item, unit_price: 1250)
        expect(item.unit_price_dollars).to eq(12.5)
      end
    end
  end
end
