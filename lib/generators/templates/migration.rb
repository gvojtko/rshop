class CreateRshopTables < ActiveRecord::Migration
  def change
    create_table :rshop_products do |t|
      t.belongs_to :rshop_album, index: true
      t.belongs_to :rshop_brand, index: true

      t.string :name
      t.string :slug, index: true
      t.integer :code
      t.decimal :price, :precision => 6, :scale => 2

      t.text :description
      t.text :description_short

      t.boolean :is_promotion
      t.boolean :is_published
      t.boolean :in_stock

      t.integer :views_count, default: 0
      t.integer :sold_count, default: 0
      t.integer :cart_count, default: 0
      t.decimal :ctb, :precision => 6, :scale => 2, default: 0
      t.decimal :ctc, :precision => 6, :scale => 2, default: 0

      t.timestamps
    end

    create_table :rshop_brands do |t|
      t.string :name
      t.string :slug
      t.string :image
      t.text :description
      t.decimal :n, :precision => 6, :scale => 2

      t.timestamps
    end

    create_table :rshop_albums do |t|
      t.string :name
      t.references :albumizable, polymorphic: true

      t.timestamps
    end

    create_table :rshop_album_images do |t|
      t.string :name
      t.string :image
      t.belongs_to :rshop_album, index: true

      t.timestamps
    end

    create_table :rshop_orders do |t|
      t.belongs_to :user, index: true
      t.belongs_to :rshop_payment, index: true
      t.belongs_to :rshop_delivery, index: true
      t.integer :status
      t.text :comments

      t.timestamps
    end

    create_table :rshop_order_items do |t|
      t.belongs_to :rshop_product, index: true
      t.belongs_to :rshop_order, index: true
      t.integer :qty

      t.timestamps
    end

    create_table :rshop_addresses do |t|
      t.string :phone
      t.string :address
      t.string :username
      t.string :email
      t.references :addressable, polymorphic: true

      t.timestamps
    end

    create_table :rshop_payments do |t|
      t.string :name

      t.timestamps
    end

    create_table :rshop_deliveries do |t|
      t.string :name

      t.timestamps
    end
  end
end
