require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:percentage).is_less_than(100) }
    it { should validate_numericality_of(:quantity) }
  end
  describe 'class methods' do
    describe '.find_holiday_discount' do
      it 'returns holiday discount' do
        merchant = create(:merchant)
        bulk_discount = merchant.bulk_discounts.create!(name: 'Labour Day Discount', quantity: 5, percentage: 25)
        holiday = 'Labour Day'
        expect(BulkDiscount.find_holiday_discount(holiday)).to eq(bulk_discount)
      end
    end
  end
end
