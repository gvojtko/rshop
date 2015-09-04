class Rshop::AutoCategory < ActiveRecord::Base
  self.table_name = 'rshop_auto_categories'
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  has_and_belongs_to_many :models, class_name: Rshop::AutoModel, join_table: :rshop_auto_models_to_categories,
                          foreign_key: :rshop_auto_category_id, association_foreign_key: :rshop_auto_model_id
  has_and_belongs_to_many :subcategories, class_name: Rshop::AutoSubcategory, join_table: :rshop_auto_categories_to_subcategories,
                          foreign_key: :rshop_auto_category_id, association_foreign_key: :rshop_auto_subcategory_id


  protected
  def should_generate_new_friendly_id?
    !slug.present?
  end
end
