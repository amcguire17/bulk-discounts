class Customer < ApplicationRecord
  has_many :invoices, :dependent => :destroy
  has_many :transactions, through: :invoices

  def self.top_five
    joins(:transactions)
      .where("result = ?", "success")
      .group(:id)
      .select("customers.*, count('transactions.result') as top")
      .order(top: :desc)
      .limit(5)
  end

  def successful_transactions
    transactions.where('result = ?', 'success').count
  end
end
