class RshopViewsGenerator < Rails::Generators::Base
  source_root File.expand_path("../../../", __FILE__)

  def create_views_files
    %w(_list.html.slim all.html.slim index.html.slim show.html.slim).each do |name|
      copy_file "app/views/rshop/products/#{name}"
    end

    %w(show.html.slim).each do |name|
      copy_file "app/views/rshop/cart/#{name}"
    end

    %w(show.html.slim).each do |name|
      copy_file "app/views/rshop/checkout/#{name}"
    end
  end
end