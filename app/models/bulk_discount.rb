class BulkDiscount < ApplicationRecord
  validates :name, presence: true
  validates :percentage, numericality: { less_than: 100 }
  validates :quantity, numericality: { only_integer: true }
  belongs_to :merchant
end
