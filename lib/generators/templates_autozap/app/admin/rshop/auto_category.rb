ActiveAdmin.register Rshop::AutoCategory do
  permit_params :name, :slug, :image, :image_cache, :remote_image_url, :remove_image
end

