class Rshop::AutoSubcategory < ActiveRecord::Base
  self.table_name = 'rshop_auto_subcategories'
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  has_and_belongs_to_many :categories, class_name: Rshop::AutoCategory, join_table: :rshop_auto_categories_to_subcategories,
                          foreign_key: :rshop_auto_subcategory_id, association_foreign_key: :rshop_auto_category_id

  protected
  def should_generate_new_friendly_id?
    !slug.present?
  end
end
