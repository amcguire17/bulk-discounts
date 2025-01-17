class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  belongs_to :invoice
  belongs_to :item
  enum status: [ :pending, :packaged, :shipped ]

  def price_display
    unit_price / 100.00
  end

  def find_discount
    item.merchant.bulk_discounts.where('quantity <= ?', quantity).order('percentage DESC').first
  end

  def discounted_revenue
    if find_discount.blank?
      (unit_price * quantity) / 100.00
    else
      ((1 - (find_discount.percentage / 100.00)) * (unit_price * quantity) / 100.00)
    end
  end
end
