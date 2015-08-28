class Rshop::AutoMark < ActiveRecord::Base
  self.table_name = 'rshop_auto_marks'
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  has_many :models, dependent: :destroy, class_name: Rshop::AutoModel, foreign_key: :rshop_auto_mark_id

  protected
  def should_generate_new_friendly_id?
    !slug.present?
  end
end
