class Rshop::Brand < ActiveRecord::Base
  self.table_name = 'rshop_brands'
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :products
  mount_uploader :image, ::RshopBrandUploader

  validates :name, presence: true

  scope :by_category, -> category do
    where(category_id: category.id)
  end

  scope :from_products, -> products do
    joins(:products).where('products.id IN (?)', products.pluck(:id)).distinct
  end

  protected

  def should_generate_new_friendly_id?
    !slug.present?
  end
end
