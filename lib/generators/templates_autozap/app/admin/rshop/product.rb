ActiveAdmin.register Rshop::Product do
  permit_params :name, :price, :description, :code, :is_promotion, :slug, :is_published, :in_stock,
                :rshop_auro_mark_id, :rshop_auto_model_id, :rshop_auto_category_id, :rshop_auto_subcategory_id,
                :category_id, :rshop_brand_id, :description_short,
                album_attributes: [:id, :name, images_attributes: [:id, :image, :image_cache, :_destroy]],
                category_ids: [], tag_ids: []

  filter :brand
  # filter :categories
  filter :name
  filter :code
  filter :product

  form do |f|
    f.inputs do
      f.input :name
      f.input :price, as: :string, hint: I18n.t("activerecord.attributes.rshop/product.price_hint")
      f.input :code
      f.input :slug
      f.input :is_promotion
      f.input :is_published
      f.input :in_stock

      f.inputs I18n.t("activerecord.attributes.rshop/product.categories") do
        # f.input :category, collection: Category.for_products.map{|u| [u.to_s_admin_selection, u.id]}, :prompt => false
        f.input :brand
        f.input :mark
        f.input :model
        f.input :category
        f.input :subcategory
        # f.input :categories, as: :select, multiple: true, collection: Category.for_products.map{|u| [u.to_s_admin_selection, u.id]}
        # f.input :tags, as: :select, multiple: true
      end

      f.inputs I18n.t("activerecord.attributes.rshop/product.description") do
        f.cktext_area :description, :ckeditor => {:language => 'ru'}
      end
      f.input :description_short, input_html: {rows: 3}

      f.inputs I18n.t("activerecord.attributes.rshop/product.album"), :for => [:album, f.object.album ], label: false do |af|
        af.has_many :images, allow_destroy: true, label: false, new_record: true do |imgf|
          imgf.input :image, as: :file, label: false, :hint => imgf.object.image.default? ? '' : imgf.template.image_tag(imgf.object.image.url(:list))
          imgf.input :image_cache, as: :hidden
        end
      end
    end
    f.actions
  end

  index do
    selectable_column
    column :name, sortable: :name do |o|
      "#{o.name}"
    end
    # column :ctb
    column :code
    column :price
    column :is_promotion
    column :is_published
    column :created_at
    column :updated_at

    actions
  end

end
