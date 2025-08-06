require 'rails_helper'

RSpec.describe "Products API", type: :request do
  let!(:category) { create(:category) }
  let!(:product) { create(:product, categories: [category]) }
  let(:valid_attributes) { attributes_for(:product).merge(category_ids: [category.id]) }

  let(:user) { create(:user) }
  let(:authorization) { "Bearer #{generate_token(create(:user))}" }
  let(:headers) { { "Authorization" => authorization, "Content-Type" => "application/json" } }

  describe "GET /products" do
    it "returns all products" do
      get "/products", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).not_to be_empty
    end
  end

  describe "GET /products/:id" do
    it "returns the product" do
      get "/products/#{product.id}", headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(product.id)
    end
  end

  describe "POST /products" do
    it "creates a new product" do
      post "/products", params: valid_attributes.to_json, headers: headers
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq(valid_attributes[:name])
    end
  end

  describe "PUT /products/:id" do
    it "updates the product" do
      put "/products/#{product.id}", params: { name: "Updated Product" }.to_json, headers: headers
      expect(response).to have_http_status(:ok)
      expect(product.reload.name).to eq("Updated Product")
    end
  end

  describe "DELETE /products/:id" do
    it "deletes the product" do
      delete "/products/#{product.id}", headers: headers
      expect(response).to have_http_status(:no_content)
      expect(Product.exists?(product.id)).to be_falsey
    end
  end
end
