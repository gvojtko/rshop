class RshopGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path("../templates", __FILE__)

  def self.next_migration_number(dirname)
    Time.now.strftime("%Y%m%d%H%M%S")
  end

  # def create_initializer_file
  #   copy_file "config/initializers/cms.rb"
  # end
  #
  def create_all_migrations
    migration_template "migration.rb", File.join('db/migrate', "create_rshop_tables.rb")
  end

  def create_cw_uploaders_files
    ['rshop_base_image_uploader.rb', 'rshop_brand_uploader.rb', 'rshop_album_image_uploader.rb'].each do |name|
      copy_file "app/uploaders/#{name}"
    end
  end

  def create_model_files
    [:product, :brand, :album, :album_image, :address, :delivery, :payment, :order, :order_item].each do |name|
      copy_file "app/models/rshop/#{name}.rb"
    end
  end

  def create_admin_files
    [:product, :brand, :payment, :delivery, :order].each do |name|
      copy_file "app/admin/rshop/#{name}.rb"
    end
  end
end