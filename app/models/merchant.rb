class Merchant < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true
  has_many :items, :dependent => :destroy
  has_many :bulk_discounts, :dependent => :destroy

  def self.top_five_by_revenue
    joins(items: [invoices: :transactions])
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price/100.0) as revenue')
    .where("transactions.result = 'success'")
    .group('merchants.id')
    .order('revenue DESC')
    .limit(5)
  end

  def top_revenue_day
    items.joins(invoices: :transactions)
    .select('invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price/100.0) as revenue')
    .where("transactions.result = 'success'")
    .group('invoices.created_at')
    .order('revenue DESC', 'invoices.created_at DESC')
    .first.created_at
  end

  def items_enabled
    items.status_enabled
  end

  def items_disabled
    items.status_disabled
  end

  def most_popular_items
    items.popular_items
  end

  def items_top_day_revenue(item_id)
    items.item_top_day(item_id)
  end
end
