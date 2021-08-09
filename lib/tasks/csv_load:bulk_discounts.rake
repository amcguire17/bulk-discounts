require 'csv'

namespace :csv_load do
  desc "Imports Bulk Discount CSV file into an ActiveRecord table"
  task :bulk_discounts => :environment do
    BulkDiscount.destroy_all
    file = './db/data/bulk_discounts.csv'
    CSV.foreach(file, :headers => true) do |row|
        BulkDiscount.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:bulk_discounts)
  end
end
