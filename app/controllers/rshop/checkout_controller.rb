class Rshop::CheckoutController < ApplicationController
  before_action :check_cart, except: [:ty]

  def form
    store_location_for :user, checkout_form_path
    @cart.address = current_user.address.dup if user_signed_in?
    @cart.validate_saving
  end

  def save
    @cart.attributes = address_params

    @cart.status = Rshop::Order::STATUS_IN_Q
    @cart.validate_saving
    if @cart.save
      sold_counter @cart
      OrderMailer.new_order(@cart).deliver
      set_cart_id nil
      session[:last_cart_id] = @cart.id
      merge_address current_user, @cart.address if current_user

      redirect_to checkout_ty_path
    else

      render 'rshop/checkout/form'
    end
  end

  def ty
    if session[:last_cart_id].present?
      # use @order to track it in google analytics
      @order = Rshop::Order.find session[:last_cart_id]
      session[:last_cart_id] = nil
    end
  end

  protected

  def sold_counter order
    order.order_items.each do |oi|
      product = oi.product
      product.sold_count = product.sold_count + qty
      product.save
    end

  rescue
  end

  def merge_address user, address
    [:phone, :address, :username, :email].each do |attr|
      user.address.send("#{attr}=", address.send(attr)) unless user.address.send(attr).present?
    end

    user.save
  end

  def check_cart
    redirect_to root_path if @cart.nil?
  end

  def address_params
    params.require(:rshop_order)
    .permit(
        :rshop_payment_id, :rshop_delivery_id, :comments,
        address_attributes: [
            :phone, :address, :username, :email
        ])
  end
end
