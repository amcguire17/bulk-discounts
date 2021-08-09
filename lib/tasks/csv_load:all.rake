namespace :csv_load do
  desc "Create seed files for all CSV"
  task :all => :environment do
    Rake::Task["csv_load:customers"].invoke
    Rake::Task["csv_load:merchants"].invoke
    Rake::Task["csv_load:invoices"].invoke
    Rake::Task["csv_load:items"].invoke
    Rake::Task["csv_load:invoice_items"].invoke
    Rake::Task["csv_load:transactions"].invoke
    Rake::Task["csv_load:bulk_discounts"].invoke
  end
end
