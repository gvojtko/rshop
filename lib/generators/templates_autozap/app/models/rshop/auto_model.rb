class Rshop::AutoModel < ActiveRecord::Base
  self.table_name = 'rshop_auto_models'
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  belongs_to :mark, class_name: Rshop::AutoMark, foreign_key: :rshop_auto_mark_id, touch: true
  has_and_belongs_to_many :categories, class_name: Rshop::AutoCategory, join_table: :rshop_auto_models_to_categories,
                          foreign_key: :rshop_auto_model_id, association_foreign_key: :rshop_auto_category_id

  protected
  def should_generate_new_friendly_id?
    !slug.present?
  end
end
