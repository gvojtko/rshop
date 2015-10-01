class Rshop::ProductsController < ApplicationController
  def show
    @product = Rshop::Product.frontend.find params[:slug]
    @product.views_count = @product.views_count + 1
    @product.save
    # @category = @product.category
    # apply_meta_tags @product
  end

  def all
    @products = Rshop::Product.frontend.page(params[:page]).per(20)
  end
end
