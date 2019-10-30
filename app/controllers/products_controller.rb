class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category,only: [:show]
  def index
    @categories = Category.all
  end

  def show
    @products = @category.products
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.create(product_params)
    redirect_to categories_path
  end

  def delete
    @product = current_user.products.find(params[:id])
    @product.destroy
  end

  def show_product
    @product = Product.find(params[:id])
    @comment = @product.comments.new
  end

  def new_comment
    @product = Product.find(params[:id])
    @comment = @product.comments.create(comment_params)
    render 'show_product'
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name,:description,:price,:category_id,:user_id,:picture)
  end

  def comment_params
    params.require(:comment).permit(:comment,:product_id)
  end

end
