module Rshop::PriceAdjustableProduct
  def self.extended(model_class)
    model_class.class_eval do
      include InstanceMethods
      before_save :apply_adjustment
    end
  end

  module InstanceMethods
    def apply_adjustment
      return nil unless adj_opt_price > 0 && (adj_percent > 0 || adj_val > 0)
      self.price = (adj_opt_price + ((adj_opt_price / 100) * adj_percent) + adj_val).round(2)
    end

    def adj_opt_price
      val = read_attribute :adj_opt_price
      val.present? ? val : 0
    end

    def adj_percent
      val = read_attribute :adj_percent
      val.present? ? val : 0
    end

    def adj_val
      val = read_attribute :adj_val
      val.present? ? val : 0
    end
  end
end