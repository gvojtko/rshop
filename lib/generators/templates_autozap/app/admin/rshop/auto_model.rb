ActiveAdmin.register Rshop::AutoModel do
  permit_params :name, :slug, :rshop_auto_mark_id,
                :image, :image_cache, :remote_image_url, :remove_image

  form do |f|
    f.inputs do
      f.input :name
      f.input :mark
      f.input :slug
    end
    f.actions
  end
end

