class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category,only: [:show]
  before_action :set_product,only: [:show_product,:edit,:update,:delete]

  def index
    # Get a list of all categories
    @categories = Category.all
  end

  def show
    # Get a list of all products
    @products = @category.products.all
  end

  def new
    # Create an instance of new product
    @product = Product.new
  end

  def create
    # Setting values for new instance of product
    @product = current_user.products.create(product_params)

    #Check if there are any validation errors
    if @product.save
    redirect_to products_path(@product), notice: "Product added successfully"
    else
      render 'new'
    end
  end

  def delete
    @product.destroy
    redirect_to user_products_path, notice: "Product deleted"
  end

  def delete_comment
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to products_path(@comment.product_id), notice: "Comment deleted"
  end

  def edit
  end

  def update
    if @product.update(product_params)
    redirect_to user_products_path,notice: "Product updated"
    else
      render 'edit'
    end
  end

  def show_product
    @product = Product.find(params[:id])
    @comment = @product.comments.new


    # For initiating Stripe session
    session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        customer_email: current_user.email,
        line_items: [{
            name: @product.name,
            description: @product.description,
            amount: @product.price.to_i * 100,
            currency: 'aud',
            quantity: 1,
        }],
        payment_intent_data: {
            metadata: {
                user_id: current_user.id,
                product_id: @product.id
            }
        },
        success_url: "#{root_url}payments/success?userId=#{current_user.id}&listingId=#{@product.id}",
        cancel_url: "#{root_url}products"
    )

    @session_id = session.id
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

  def show_new_product
    @products = Product.order(:created_at)
  end

  private
  def set_category
    @category = Category.find(params[:id])
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name,:description,:price,:category_id,:user_id,:picture)
  end

  def comment_params
    params.require(:comment).permit(:comment,:product_id)
  end

  def category_params
    params.require(:category).permit(:name,:description,:image)
  end

end
