class Rshop::Product < ActiveRecord::Base
  self.table_name = 'rshop_products'
  # ctb - cart to buy
  # ctc - click to cart
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_one :album, as: :albumizable, dependent: :destroy, class_name: Rshop::Album
  belongs_to :brand, touch: true, class_name: Rshop::Brand, foreign_key: :rshop_brand_id

  belongs_to :mark, touch: true, class_name: Rshop::AutoMark, foreign_key: :rshop_auro_mark_id
  belongs_to :model, touch: true, class_name: Rshop::AutoModel, foreign_key: :rshop_auto_model_id
  belongs_to :category, touch: true, class_name: Rshop::AutoCategory, foreign_key: :rshop_auto_category_id
  belongs_to :subcategory, touch: true, class_name: Rshop::AutoSubcategory, foreign_key: :rshop_auto_subcategory_id

  accepts_nested_attributes_for :album, allow_destroy: true
  after_initialize :init
  before_save :calc_ctb, :calc_ctc

  validates :name, :price, presence: true
  validates :mark, :model, :category, :subcategory, presence: true

  default_scope -> { where(is_published: true).order("cart_count desc").order('is_promotion desc') }

  scope :order_by_smth, -> order_by do
    order(order_by)
  end

  def get_name_font
    case name.length
      when 0..24
        'name-xs'
      when 25..45
        'name-sm'
      when 46..60
        'name-md'
      else
        'name-lg'
    end
  end

  def image_url variant = nil
    image = self.album.images.first
    path = image.try(:url, variant)
    path ? path : Rshop::AlbumImage.new.url(variant)
  end

  protected

  def calc_ctb
    if cart_count + sold_count <= 0
      self.ctb = 0
      return
    end

    if sold_count == 0
      self.sold_count = 1
    end
    self.ctb = sold_count / cart_count

  rescue StandardError => e
    p e.to_s
  end

  def calc_ctc
    if views_count + cart_count <= 0
      self.ctc = 0
      return
    end

    if views_count == 0
      self.views_count = 1
    end
    self.ctc = cart_count / views_count

  rescue StandardError => e
    p e.to_s
  end

  def remove_from_category category
    category.products.delete self
  end

  def should_generate_new_friendly_id?
    !slug.present?
  end

  def init
    unless self.persisted?
      self.in_stock = true
      self.album = Rshop::Album.new if self.album.nil?
    end
  end
end
