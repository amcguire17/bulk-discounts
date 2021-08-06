class CreateDiscountedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :discounted_items do |t|
      t.references :item, foreign_key: true
      t.references :bulk_discount, foreign_key: true
      t.timestamps
    end
  end
end
