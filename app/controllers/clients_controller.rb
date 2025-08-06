class ClientsController < ApplicationController
before_action :authorize_request
  before_action :set_client, only: [ :destroy ]

  # GET /clients
  def index
    clients = ClientService::List.new(filter_params).call
    render json: clients
  end

  # GET /clients/:id
  def show
    client = ClientService::Show.new(params[:id]).call
    render json: client
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Cliente no encontrado" }, status: :not_found
  end

  # POST /clients
  def create
    client = ClientService::Create.new(client_params).call
    render json: client, status: :created
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # PUT /clients/:id
  def update
    client = ClientService::Update.new(params[:id], client_params).call
    render json: client
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Cliente no encontrado" }, status: :not_found
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # DELETE /clients/:id
  def destroy
    @client.destroy
    head :no_content
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def filter_params
      params.permit(:name, :email)
  end

  def client_params
      params.permit(:name, :email)
  end
end
