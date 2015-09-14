class Rshop::PriceLog < ActiveRecord::Base
  self.table_name = 'rshop_price_logs'
  belongs_to :product, class_name: Rshop::Product, foreign_key: :rshop_product_id
  validates :price, presence: true
end
