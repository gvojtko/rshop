class Rshop::Album < ActiveRecord::Base
  self.table_name = 'rshop_albums'
  has_many :images, dependent: :destroy, class_name: Rshop::AlbumImage, foreign_key: :rshop_album_id
  belongs_to :albumizable, polymorphic: true, touch: true

  accepts_nested_attributes_for :images, :allow_destroy => true

  def has_images?
    images[0].present?
  end
end
