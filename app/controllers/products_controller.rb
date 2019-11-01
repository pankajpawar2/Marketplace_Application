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
    @product = Product.find(params[:id])
    @product.destroy
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to products_path,notice: "Product updated"
  end

  def show_product
    @product = Product.find(params[:id])
    @comment = @product.comments.new
  end

  def show_user_product
    @products = current_user.products
  end

  def new_comment
    @product = Product.find(params[:id])
    @comment = @product.comments.create(comment_params)
    render 'show_product'
  end

  def new_category
    @category = Category.new
  end

  def create_new_category
    @category = Category.new(category_params)
    @category.save
    redirect_to categories_path,notice: "Category Added successfully"
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

  def category_params
    params.require(:category).permit(:name,:image_url)
  end

end
