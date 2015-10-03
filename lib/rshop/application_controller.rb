module Rshop
  module ApplicationController
    def self.included(base)
      base.class_eval do
        # extend Base
        include ClassMethods
        helper_method :cart_view
        before_filter :setup_cart
      end
    end

    module ClassMethods
      def cart_view
        get_cart || Rshop::Order.new(user: current_user)
      end
      # cart
      def get_cart
        id = get_cart_id
        order = (Rshop::Order.find(id) rescue nil) unless id.nil?
        set_cart_id nil if order.nil?
        order
      end

      def get_cart_id
        session[:cart_id]
      end

      def set_cart_id cart_id
        session[:cart_id] = cart_id
        cart_id
      end

      # cart other
      def upsert_cart
        @cart = new_cart if @cart.nil?
        @cart
      end

      def new_cart
        order = Rshop::Order.create!(user: current_user)
        set_cart_id order.id
        order
      end

      def check_cart_is_empty
        @cart.destroy! unless @cart.nil? || @cart.has_items?
      end

      protected
      def setup_cart
        @cart = get_cart
      end
    end
  end
end