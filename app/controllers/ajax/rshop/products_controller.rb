class Ajax::Rshop::ProductsController < ApplicationController
  def search
    products = Rshop::Product.where("name LIKE ?", "%#{params[:q]}%").limit(10)
    arr = products.map{|product| {id: product.name, text: product.name} }

    render text: {items: arr, page: current_page}.to_json
  end

  def current_page
    params[:page] ? params[:page] : 1
  end
end