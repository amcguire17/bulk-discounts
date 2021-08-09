require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end
  describe 'validations' do
    it { should validate_numericality_of(:percentage).is_less_than(100) }
    it { should validate_numericality_of(:quantity) }
  end
end