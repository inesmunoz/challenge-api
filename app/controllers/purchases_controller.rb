class PurchasesController < ApplicationController
  before_action :authorize_request
  before_action :set_purchase, only: [ :destroy ]

  # GET /purchases
  def index
    purchases = PurchaseService::List.new(filter_params).call
    render json: purchases
  end

  # GET /purchases/:id
  def show
    purchase = PurchaseService::Show.new(params[:id]).call
    render json: purchase
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Producto no encontrado" }, status: :not_found
  end

  # POST /purchases
  def create
    purchase = PurchaseService::Create.new(purchase_params).call
    render json: purchase, status: :created
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PUT /purchases/:id
  def update
    purchase = PurchaseService::Update.new(params[:id], purchase_params).call
    render json: purchase
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Producto no encontrado" }, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # DELETE /purchases/:id
  def destroy
    @purchase.destroy
    head :no_content
  end

  private

  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  def filter_params
      params.permit(:client_id, :product_id, :quantity, :total_price)
  end

  def purchase_params
      params.permit(:client_id, :product_id, :quantity, :total_price)
  end
end
