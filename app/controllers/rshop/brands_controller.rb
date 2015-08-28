class Rshop::BrandsController < ApplicationController
  def show
    @brand = Rshop::Brand.find params[:slug]
  end

  def index
    @brands = Rshop::Brand.all.page(params[:page]).per(20)
  end
end
