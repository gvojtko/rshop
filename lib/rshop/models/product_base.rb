module Rshop
  module ProductBase
    # ctb - cart to buy rate
    # ctc - click to cart rate

    def self.included base
      base.instance_eval do
        extend FriendlyId
        friendly_id :name, use: [:slugged, :finders]

        has_one :album, as: :albumizable, dependent: :destroy, class_name: Rshop::Album
        belongs_to :brand, touch: true, class_name: Rshop::Brand, foreign_key: :rshop_brand_id

        accepts_nested_attributes_for :album, allow_destroy: true
        after_initialize :init
        before_save :calc_ctb, :calc_ctc

        validates :name, :price, presence: true

        scope :frontend, -> {where(is_published: true)}

        include InstanceMethods
      end
    end

    module InstanceMethods
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

  end
end
