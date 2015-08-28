class Rshop::AutoCategory < ActiveRecord::Base
  self.table_name = 'rshop_auto_categories'
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  protected
  def should_generate_new_friendly_id?
    !slug.present?
  end
end
