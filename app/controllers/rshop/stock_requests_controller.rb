class Rshop::StockRequestsController < ApplicationController
  def create
    @req = Rshop::StockRequest.new get_params

    if @req.save
      product = Rshop::Product.find @req.rshop_product_id
      redirect_to :back, flash: { success: t('rshop.stock_request.created', name: product.name) }
    else
      render :create
    end
  end

  protected
  def get_params
    params.require(:rshop_stock_request).permit(:contact, :rshop_product_id, :comment)
  end
end
