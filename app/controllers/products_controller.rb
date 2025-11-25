class ProductsController < ApplicationController
  def index
    @categories = Category.all

    @products = Product.all

    # Search filter
    if params[:search].present?
      keyword = "%#{params[:search]}%"
      @products = @products.where("name ILIKE ? OR description ILIKE ?", keyword, keyword)
    end

    # Category filter
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    # Pagination (MUST be last)
    @products = @products.page(params[:page]).per(8)
  end

  def show
    @product = Product.find(params[:id])
  end
end
