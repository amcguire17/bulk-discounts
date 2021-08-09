require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:bulk_discounts) }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
  end
  describe 'class methods' do
    before :each do
      @merchant_1 = create(:merchant, status: 'enabled')
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant, status: 'enabled')
      @merchant_4 = create(:merchant, status: 'enabled')
      @merchant_5 = create(:merchant, status: 'enabled')
      @merchant_6 = create(:merchant)
      @merchant_7 = create(:merchant)

      @item_1 = create(:item, unit_price: 12000, merchant: @merchant_1)
      @item_2 = create(:item, unit_price: 10100, merchant: @merchant_1)
      @item_3 = create(:item, unit_price: 5000, merchant: @merchant_3)
      @item_4 = create(:item, unit_price: 7500, merchant: @merchant_3)
      @item_5 = create(:item, unit_price: 9000, merchant: @merchant_4)
      @item_6 = create(:item, unit_price: 8500, merchant: @merchant_4)
      @item_7 = create(:item, unit_price: 10000, merchant: @merchant_5)
      @item_8 = create(:item, unit_price: 7500, merchant: @merchant_5)
      @item_9 = create(:item, unit_price: 11500, merchant: @merchant_6)
      @item_10 = create(:item, unit_price: 10000, merchant: @merchant_7)

      @invoice_1 = create(:invoice)
      @invoice_2 = create(:invoice)
      @invoice_3 = create(:invoice, status: 'completed', created_at: '2019-07-24 21:54:10 UTC')
      @invoice_4 = create(:invoice, status: 'completed', created_at: '2020-06-24 21:54:10 UTC')
      @invoice_5 = create(:invoice)
      @invoice_6 = create(:invoice)

      @transactions_1 = create(:transaction, invoice: @invoice_1)
      @transactions_2 = create(:transaction, invoice: @invoice_2)
      @transactions_3 = create(:transaction, invoice: @invoice_3)
      @transactions_4 = create(:transaction, invoice: @invoice_4)
      @transactions_5 = create(:transaction, invoice: @invoice_5)
      @transactions_6 = create(:transaction, invoice: @invoice_6)

      @invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 12000, item: @item_1, invoice: @invoice_1)
      @invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 10100, item: @item_2, invoice: @invoice_1)
      @invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 20000, item: @item_10, invoice: @invoice_2)
      @invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 15000, item: @item_4, invoice: @invoice_3)
      @invoice_item_1 = create(:invoice_item, quantity: 3, unit_price: 15000, item: @item_3, invoice: @invoice_4)
      @invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 9000, item: @item_5, invoice: @invoice_5)
      @invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 23000, item: @item_9, invoice: @invoice_6)
    end
    describe '.enabled' do
      it 'returns all merchants that are enabled' do
        expect(Merchant.status_enabled).to eq([@merchant_1, @merchant_3, @merchant_4, @merchant_5])
      end
    end
    describe '.disabled' do
      it 'returns all merchants that are disabled' do
          expect(Merchant.status_disabled).to eq([@merchant_2, @merchant_6, @merchant_7])
      end
    end
    describe '.top_five_by_revenue' do
      it 'returns the top 5 merchants by revenue' do
        expect(Merchant.top_five_by_revenue).to eq([@merchant_3, @merchant_6, @merchant_7, @merchant_1, @merchant_4])
      end
    end
  end
  describe 'instance methods' do
    before :each do
      @merchant_1 = create(:merchant, status: 'enabled')
      @customer = create(:customer)
      @item_1 = create(:item, merchant: @merchant_1, status: 'enabled')
      @item_2, @item_3, @item_4, @item_5, @item_6 = create_list(:item, 5, merchant: @merchant_1)
      @invoice_1 = create(:invoice, customer: @customer, status: 'completed', created_at: '2021-03-06 21:54:10 UTC')
      @invoice_2 = create(:invoice, customer: @customer, status: 'completed')
      @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, quantity: 1, unit_price: 5000)
      @invoice_item_2 = create(:invoice_item, invoice: @invoice_1, item: @item_2, quantity: 1, unit_price: 2000)
      @invoice_item_3 = create(:invoice_item, invoice: @invoice_1, item: @item_3, quantity: 1, unit_price: 9000)
      @invoice_item_4 = create(:invoice_item, invoice: @invoice_1, item: @item_4, quantity: 1, unit_price: 4000)
      @invoice_item_5 = create(:invoice_item, invoice: @invoice_2, item: @item_5, quantity: 1, unit_price: 1000)
      @invoice_item_6 = create(:invoice_item, invoice: @invoice_2, item: @item_6, quantity: 1, unit_price: 3000)
      @transaction_1 = create(:transaction, result: 'success', invoice: @invoice_1)
      @transaction_2 = create(:transaction, result: 'success', invoice: @invoice_2)
    end
    describe '#top_revenue_day' do
      it 'returns the date with the most revenue for each merchant' do
        merchant_3 = create(:merchant, status: 'enabled')
        item_3 = create(:item, unit_price: 5000, merchant: merchant_3)
        item_4 = create(:item, unit_price: 7500, merchant: merchant_3)
        invoice_3 = create(:invoice, status: 'completed', created_at: '2019-07-24 21:54:10 UTC')
        invoice_4 = create(:invoice, status: 'completed', created_at: '2020-06-24 21:54:10 UTC')
        transactions_3 = create(:transaction, invoice: invoice_3)
        transactions_4 = create(:transaction, invoice: invoice_4)
        invoice_item_1 = create(:invoice_item, quantity: 2, unit_price: 15000, item: item_4, invoice: invoice_3)
        invoice_item_1 = create(:invoice_item, quantity: 3, unit_price: 15000, item: item_3, invoice: invoice_4)
        expect(merchant_3.top_revenue_day).to eq('2020-06-24 21:54:10 UTC')
      end
    end
    describe '#items_enabled' do
      it 'returns all merchants items with status enabled' do
        expect(@merchant_1.items_enabled).to eq([@item_1])
      end
    end
    describe '#items_disabled' do
      it 'returns all merchants items with status disabled' do
        expect(@merchant_1.items_disabled).to eq([@item_2, @item_3, @item_4, @item_5, @item_6])
      end
    end
    describe '#most_popular_items' do
      it 'returns merchants top 5 items by revenue' do
        expect(@merchant_1.most_popular_items).to eq([@item_3, @item_1, @item_4, @item_6, @item_2])
      end
    end
    describe '#items_top_day_revenue' do
      it 'returns merchants top date of sales for item' do
        expect(@merchant_1.items_top_day_revenue(@item_1.id)).to eq(Time.parse('2021-03-06 21:54:10 UTC'))
      end
    end
  end

end
