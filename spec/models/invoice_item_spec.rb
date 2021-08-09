require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do

  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  before :each do
    @merchant = create(:merchant)
    @invoice = create(:invoice)
    @item = create(:item, merchant: @merchant)
    @invoice_item = InvoiceItem.create!(
      invoice: @invoice,
      item: @item,
      quantity: 7,
      unit_price: 11111,
      status: 0
    )
  end

  describe 'instance methods' do
    describe '#price_display' do
      it 'displays unit_price in dollar amount' do
        expect(@invoice_item.price_display).to eq(111.11)
      end
    end
  end
  describe '#find_discount' do
    it 'returns discount for invoice_item' do
      bulk_discount = @merchant.bulk_discounts.create!(percentage: 15, quantity: 5)
      bulk_discount_2 = @merchant.bulk_discounts.create!(percentage: 20, quantity: 7)
      expect(@invoice_item.find_discount).to eq(bulk_discount_2)
    end
  end
  describe '#discounted_revenue' do
    it 'returns discounted revenue for invoice_item' do
      bulk_discount = @merchant.bulk_discounts.create!(percentage: 15, quantity: 5)
      bulk_discount_2 = @merchant.bulk_discounts.create!(percentage: 20, quantity: 7)
      expect(@invoice_item.discounted_revenue).to eq(622.216)
    end
  end
end
