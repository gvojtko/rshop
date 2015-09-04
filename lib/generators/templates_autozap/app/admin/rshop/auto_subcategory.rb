ActiveAdmin.register Rshop::AutoSubcategory do
  permit_params :name, :slug, :image, :image_cache, :remote_image_url, :remove_image,
                category_ids: []

  form do |f|
    f.inputs do
      f.input :name
      f.input :slug
      f.input :categories, hint: 'много подкатегорий относятся ко многим категориям'
    end
    f.actions
  end
end

