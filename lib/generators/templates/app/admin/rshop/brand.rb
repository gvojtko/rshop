ActiveAdmin.register Rshop::Brand do
  permit_params :name, :description, :category_id,:image, :image_cache, :remove_image, :n, :slug

  form do |f|
    f.inputs do
      f.input :name
      f.input :n
      f.input :slug
      f.inputs "" do
        f.cktext_area :description, :ckeditor => {:language => 'ru'}
      end
      f.inputs "" do
        f.input :image, as: :file, :hint => f.object.image.default? ? '' : f.template.image_tag(f.object.image.url(:list))
        f.input :image_cache, as: :hidden
        f.input :remove_image, as: :boolean
      end

      f.actions
    end
  end

  filter :name

end
