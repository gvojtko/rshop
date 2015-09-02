class Rshop::CartController < ::ApplicationController
  after_action :check_cart_is_empty

  def create_item
    upsert_cart

    product = Rshop::Product.find params[:product_id]

    qty = order_item_params[:qty].to_i
    qty = qty > 0 ? qty : 1
    @cart.order_items.create! product: product,
                              qty: qty
    @cart.save!
    cart_counter product, qty

    redirect_to root_path, flash: { success: t("rshop.cart_item.created", name: "\"#{product.name}\" (#{qty}шт.)") }
  end

  def delete_item
    order_item = @cart.order_items.find(params[:id])
    product = order_item.product
    order_item.destroy!

    redirect_to request.headers['referer'], flash: { info: t("rshop.cart_item.deleted", name: "\"#{product.name}\" (#{order_item.qty}шт.)") }
  end

  def delete
    @cart.order_items.destroy_all

    redirect_to cart_path, flash: { warning: ("rshop.cart.flushed") }
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
    params.require(:rshop_order).permit(order_items_attributes: order_item_params_list)
  end

  def order_item_params
    params.permit(order_item_params_list)
  end

  def order_item_params_list
    [:qty, :id]
  end
end
