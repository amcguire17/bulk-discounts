require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:invoices) }
  end
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end
  describe 'class methods' do
    before :each do
      @customers = create_list(:customer, 7)
      @merchant = create(:merchant)
      @item = create(:item, merchant: @merchant)

      @invoices = @customers.map do |customer|
        create(:invoice, customer: customer)
      end

      @invoice_items = @invoices.map do |invoice|
        create(:invoice_item, item: @item, invoice: invoice)
      end

      create_list(:transaction, 2, result: 'failed', invoice: @invoices[0])
      create_list(:transaction, 4, result: 'success', invoice: @invoices[1])
      create_list(:transaction, 5, result: 'success', invoice: @invoices[2])
      create_list(:transaction, 1, result: 'success', invoice: @invoices[3])
      create_list(:transaction, 1, result: 'success', invoice: @invoices[4])
      create_list(:transaction, 3, result: 'success', invoice: @invoices[5])
      create_list(:transaction, 6, result: 'success', invoice: @invoices[6])
    end
    describe '.top_five' do
      it 'returns 5 customers with highest number of successful transactions' do
        customer_list = [@customers[6],@customers[2],@customers[1],@customers[5],@customers[3]]
        expect(Customer.top_five).to eq(customer_list)
      end
    end
    describe '.top_five_customers_by_transactions' do
      it 'returns the top 5 customers with largest number of successful transactions' do
        expected = [@customers[6], @customers[2], @customers[1], @customers[5], @customers[3]]
        expect(Customer.top_five_customers_by_transactions(@merchant.id)).to eq(expected)
      end
    end
  end
  describe 'instance methods' do
    before :each do
      @customers = create_list(:customer, 3)

      @customers.each do |customer|
        create_list(:invoice, 1, customer: customer)
      end

      create_list(:transaction, 2, result: 'failed', invoice: @customers[0].invoices.first)
      create_list(:transaction, 2, result: 'success', invoice: @customers[1].invoices.first)
      create_list(:transaction, 4, result: 'success', invoice: @customers[2].invoices.first)
    end
    describe '#successful_transactions' do
      it 'displays successful transactions' do
        expect(@customers[0].successful_transactions).to eq(0)
        expect(@customers[1].successful_transactions).to eq(2)
        expect(@customers[2].successful_transactions).to eq(4)
      end
    end
  end
end
