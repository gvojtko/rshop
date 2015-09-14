class Rshop::AutoProductsController < ApplicationController
  def filter
    qb = Rshop::Product.all

    if params[:mark].present?
      qb = qb.joins(:mark).where("#{Rshop::AutoMark.table_name}.name LIKE ?", "%#{params[:mark]}%")
    end

    if params[:model].present?
      qb = qb.joins(:model).where("#{Rshop::AutoModel.table_name}.name LIKE ?", "%#{params[:model]}%")
    end

    if params[:category].present?
      qb = qb.joins(:category).where("#{Rshop::AutoCategory.table_name}.name LIKE ?", "%#{params[:category]}%")
    end

    if params[:subcategory].present?
      qb = qb.joins(:subcategory).where("#{Rshop::AutoSubcategory.table_name}.name LIKE ?", "%#{params[:subcategory]}%")
    end

    set_auto_filters mark: params[:mark], model: params[:model], category: params[:category],
                     subcategory: params[:subcategory]
    @products = qb.page(params[:page]).per(20)

    render 'rshop/products/index'
  end

  def search
    @product =  Rshop::Product.find_by name: params[:q]

    if @product
      render 'rshop/products/show'
    else
      @products = Rshop::Product.search(params[:q]).page(params[:page]).per(20)
      render 'rshop/products/index'
    end
  end
end