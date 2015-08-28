class CreateRshopAutozapTables < ActiveRecord::Migration
  def change
    create_table :rshop_auto_marks do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    create_table :rshop_auto_models do |t|
      t.string :name
      t.string :slug
      t.belongs_to :rshop_auto_mark

      t.timestamps
    end

    create_table :rshop_auto_models_to_categories do |t|
      t.belongs_to :rshop_auto_model
      t.belongs_to :rshop_auto_category

      t.timestamps
    end

    create_table :rshop_auto_categories do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    create_table :rshop_auto_categories_to_subcategories do |t|
      t.belongs_to :rshop_auto_category
      t.belongs_to :rshop_auto_subcategory

      t.timestamps
    end

    create_table :rshop_auto_subcategories do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    add_column :rshop_products, :rshop_auro_mark_id, :integer
    add_column :rshop_products, :rshop_auto_model_id, :integer
    add_column :rshop_products, :rshop_auto_category_id, :integer
    add_column :rshop_products, :rshop_auto_subcategory_id, :integer
  end
end
