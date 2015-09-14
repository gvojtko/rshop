module Rshop::PriceLoggableProduct
  def self.extended(model_class)
    model_class.class_eval do
      has_many :price_logs, class_name: Rshop::PriceLog, foreign_key: :rshop_product_id
      include InstanceMethods
      before_save :add_price_log
    end
  end

  module InstanceMethods
    def add_price_log
      if price_changed? || in_stock_changed?
        price_logs.where('created_at >= ?', Time.now.strftime('%F'))
            .where('created_at < ?', (Time.now + 1.day).strftime('%F')).destroy_all
        price_logs.create(price: price, in_stock: in_stock)
      end
    end
  end
end
