class ProductsController < ApplicationController
  before_action :authorize_request
  before_action :set_product, only: [:destroy]

  # GET /products
  def index
    products = ProductService::List.new(filter_params).call
    render json: products
  end

   # GET /products/:id
  def show
    product = ProductService::Show.new(params[:id]).call
    render json: product
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Producto no encontrado" }, status: :not_found
  end

  # POST /products
  def create
    product = ProductService::Create.new(product_params).call

    if product.valid?
      render json: product, status: :created
    else
      render json: { errors: product.errors.full_messages }, status: :unprocessable_entity
    end
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PUT /products/:id
  def update
    product = ProductService::Update.new(params[:id], product_params).call
    render json: product
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Producto no encontrado" }, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def filter_params
      params.permit(:name, :price, :stock, :product_type, category_ids: [])
  end

  def product_params
      params.permit(:name, :price, :stock, :product_type, category_ids: [])
  end

end
