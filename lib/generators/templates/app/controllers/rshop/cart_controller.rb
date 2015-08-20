class Rshop::CartController < ApplicationController
  after_action :check_cart_is_empty

  def create_item
    upsert_cart

    product = Product.find params[:product_id]

    qty = order_item_params[:qty].to_i
    qty = qty > 0 ? qty : 1
    @cart.order_items.create! product: product,
                              qty: qty
    @cart.save!
    cart_counter product, qty

    redirect_to permalink_path(product.category), flash: { success: "Товар \"#{product.name}\" (#{qty}шт.) був доданий в корзину" }
  end

  def delete_item
    order_item = @cart.order_items.find(params[:id])
    product = order_item.product
    order_item.destroy!

    redirect_to request.headers['referer'], flash: { warning: "\"#{product.name}\" видалений з корзини" }
  end

  def delete
    @cart.order_items.destroy_all

    redirect_to cart_path, flash: { warning: "Корзина очищена" }
  end

  def update
    @cart.update_attributes cart_params

    redirect_to params[:buy_action].nil? ? cart_path : checkout_form_path
  end

  def show
  end

  protected

  def cart_counter product, qty
    product.cart_count = product.cart_count + qty
    product.save
  rescue
  end

  def cart_params
    params.require(:order).permit(order_items_attributes: order_item_params_list)
  end

  def order_item_params
    params.permit(order_item_params_list)
  end

  def order_item_params_list
    [:qty, :id]
  end
end
