require 'rails_helper'

RSpec.describe "Purchases API", type: :request do
  let!(:client) { create(:client) }
  let!(:product) { create(:product) }
  let!(:purchase) { create(:purchase, client: client, product: product) }
  let(:valid_attributes) { attributes_for(:purchase).merge(client_id: client.id, product_id: product.id) }

  let(:user) { create(:user) }
  let(:token) { generate_token(user) }

  let(:headers) do
    {
      "Authorization" => "Bearer #{token}",
      "Content-Type" => "application/json"
    }
  end

  describe "GET /purchases" do
    it "returns all purchases" do
      get "/purchases", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).not_to be_empty
    end
  end

  describe "GET /purchases/:id" do
    it "returns the purchase" do
      get "/purchases/#{purchase.id}", headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(purchase.id)
    end
  end

  describe "POST /purchases" do
    it "creates a new purchase" do
      post "/purchases", params: valid_attributes.to_json, headers: headers
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["client_id"]).to eq(client.id)
      expect(json["product_id"]).to eq(product.id)
    end
  end

  describe "PUT /purchases/:id" do
    it "updates the purchase" do
      put "/purchases/#{purchase.id}", params: { quantity: 10 }.to_json, headers: headers
      expect(response).to have_http_status(:ok)
      expect(purchase.reload.quantity).to eq(10)
    end
  end

  describe "DELETE /purchases/:id" do
    it "deletes the purchase" do
      delete "/purchases/#{purchase.id}", headers: headers
      expect(response).to have_http_status(:no_content)
      expect(Purchase.exists?(purchase.id)).to be_falsey
    end
  end
end
