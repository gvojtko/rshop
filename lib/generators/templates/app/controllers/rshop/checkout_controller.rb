class Rshop::CheckoutController < ApplicationController
  before_action :check_cart, except: [:ty]

  def form
    store_location_for :user, checkout_form_path
    @cart.address = current_user.address.dup if user_signed_in?
    @cart.validate_saving
  end

  def save
    order_params = address_params

    if @cart.address.valid_phone?
      @cart.payment_id = order_params[:payment_id]
      @cart.delivery_id = order_params[:delivery_id]
      @cart.comments = order_params[:comments]
    else
      @cart.attributes = address_params
    end

    @cart.status = Order::STATUS_IN_Q
    @cart.validate_saving
    if @cart.save
      sold_counter @cart
      OrderMailer.new_order(@cart).deliver
      set_cart_id nil
      session[:last_cart_id] = @cart.id
      merge_address current_user, @cart.address if current_user

      redirect_to checkout_ty_path
    else

      render 'checkout/form'
    end
  end

  def ty
    if session[:last_cart_id].present?
      # use @order to track it in google analytics
      @order = Order.find session[:last_cart_id]
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
    user.address.phone = address.phone if user.address.phone.nil? || user.address.phone == ''
    user.address.address = address.address if user.address.address.nil? || user.address.address == ''
    user.address.username = address.username if user.address.username.nil? || user.address.username == ''
    user.address.email = address.address if user.address.email.nil? || user.address.email == ''

    user.save
  end

  def check_cart
    redirect_to root_path if @cart.nil?
  end

  def address_params
    params.require(:order)
    .permit(
        :payment_id, :delivery_id, :comments,
        address_attributes: [
        :phone, :address, :username, :email
    ])
  end
end
