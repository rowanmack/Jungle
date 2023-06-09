class CategoriesController < ApplicationController

  def index
    @category = Category.find(params[:id])
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc)
  end

end
