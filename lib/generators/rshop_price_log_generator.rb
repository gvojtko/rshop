class RshopPriceLogGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path("../templates_price_log", __FILE__)

  def self.next_migration_number(dirname)
    Time.now.strftime("%Y%m%d%H%M%S")
  end

  def create_all_migrations
    migration_template "migration.rb", File.join('db/migrate', "create_rshop_price_log_tables.rb")
  end

  def create_model_files
    [:price_log].each do |name|
      copy_file "app/models/rshop/#{name}.rb"
    end
  end
  #
  # def create_admin_files
  #   [:auto_mark, :auto_model, :auto_category, :auto_subcategory, :product].each do |name|
  #     copy_file "app/admin/rshop/#{name}.rb"
  #   end
  # end
  #
  # def create_views_files
  #   %w(_filters.html.slim).each do |name|
  #     copy_file "app/views/rshop/auto/#{name}"
  #   end
  # end
end