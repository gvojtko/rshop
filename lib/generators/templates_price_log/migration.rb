class CreateRshopAutozapTables < ActiveRecord::Migration
  def change
    create_table :rshop_price_logs do |t|
      t.decimal :price, :precision => 6, :scale => 2, default: 0
      t.belongs_to :rshop_product, index: true

      t.timestamps null: false
    end
  end
end
