ActiveAdmin.register Rshop::AutoMark do
  permit_params :name, :slug, :image, :image_cache, :remote_image_url, :remove_image,
                model_ids: []

  form do |f|
    f.inputs do
      f.input :name
      f.input :slug
      f.input :models, hint: 'одна марка может иметь много моделей'

    end
    f.actions
  end
end

