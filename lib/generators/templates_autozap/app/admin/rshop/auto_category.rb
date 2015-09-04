ActiveAdmin.register Rshop::AutoCategory do
  permit_params :name, :slug, :image, :image_cache, :remote_image_url, :remove_image,
                subcategory_ids: [], model_ids: []

  form do |f|
    f.inputs do
      f.input :name
      f.input :slug
      f.input :models, hint: 'одна марка может иметь много моделей'
      f.input :subcategories, hint: 'много категорий могут относится ко многим подкатегориям'

    end
    f.actions
  end
end

