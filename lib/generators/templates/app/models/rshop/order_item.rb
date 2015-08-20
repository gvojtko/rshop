class Rshop::OrderItem < ActiveRecord::Base
  self.table_name = 'rshop_order_items'
  belongs_to :product, touch: true, class_name: Rshop::Product, foreign_key: :rshop_product_id
  belongs_to :order, touch: true, class_name: Rshop::Order, foreign_key: :rshop_order_id

  def cost
    self.product.price * self.qty
  end
end
