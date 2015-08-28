class Rshop::AutoModel < ActiveRecord::Base
  self.table_name = 'rshop_auto_models'
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  belongs_to :mark, class_name: Rshop::AutoMark, foreign_key: :rshop_auto_mark_id, touch: true

  protected
  def should_generate_new_friendly_id?
    !slug.present?
  end
end
