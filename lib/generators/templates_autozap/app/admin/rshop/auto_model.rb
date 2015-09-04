ActiveAdmin.register Rshop::AutoModel do
  permit_params :name, :slug, :rshop_auto_mark_id,
                :image, :image_cache, :remote_image_url, :remove_image,
                category_ids: []

  form do |f|
    f.inputs do
      f.input :name
      f.input :mark, hint: 'одна модель относится к одной марке'
      f.input :slug
      f.input :categories, hint: 'много моделей относятся ко многим категориям'
    end
    f.actions
  end
end

