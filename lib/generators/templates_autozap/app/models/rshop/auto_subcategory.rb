class Rshop::AutoSubcategory < ActiveRecord::Base
  self.table_name = 'rshop_auto_subcategories'
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  protected
  def should_generate_new_friendly_id?
    !slug.present?
  end
end
