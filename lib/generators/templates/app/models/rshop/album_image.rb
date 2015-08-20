class Rshop::AlbumImage < ActiveRecord::Base
  self.table_name = 'rshop_album_images'
  belongs_to :album, touch: true, class_name: Rshop::Album, foreign_key: :rshop_album_id
  mount_uploader :image, ::RshopAlbumImageUploader

  delegate :url, to: :image
end
