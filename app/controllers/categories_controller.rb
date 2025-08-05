class CategoriesController < ApplicationController
  before_action :authorize_request
  before_action :set_category, only: [:destroy]

  # GET /categories
  def index
    categories = CategoryService::List.new(filter_params).call
    render json: categories
  end

  # GET /categories/:id
  def show
    category = CategoryService::Show.new(params[:id]).call
    render json: category
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Categoria no encontrada" }, status: :not_found
  end

  # POST /categories
  def create
    category = CategoryService::Create.new(category_params).call
    render json: category, status: :created
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end


  # PUT /categories/:id
  def update
    category = CategoryService::Update.new(params[:id], category_params).call
    render json: category
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Categoria no encontrada" }, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
  # DELETE /categories/:id
  def destroy
    @category.destroy
    head :no_content
  end

   private

  def set_category
    @category = Category.find(params[:id])
  end
  
  def filter_params
      params.permit(:name)
  end

  def category_params
      params.permit(:name)
  end
end
