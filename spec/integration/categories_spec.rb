require 'rails_helper'

RSpec.describe "Categories API", type: :request do
  let!(:category) { create(:category) }
  let(:valid_attributes) { attributes_for(:category) }
   let!(:role) { Role.find_or_create_by!(name: "administrador") }
  let!(:user) do
    User.find_by(email: "test@example.com") ||
      User.create!(
        email: "test@example.com",
        password: "123456",
        role: role
      )
  end  
  let!(:categories) { create_list(:category, 3) }
  let(:authorization) { "Bearer #{generate_token(create(:user))}" }
  let(:headers) { { "Authorization" => authorization, "Content-Type" => "application/json" } }

  describe "GET /categories" do
    it "returns all categories" do
      get "/categories", headers: headers  
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body) 
      expect(json).not_to be_empty
    end
  end

  describe "GET /categories/:id" do
    it "returns the category" do
      get "/categories/#{category.id}", headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(category.id)
    end
  end

  describe "POST /categories" do
    it "creates a new category" do
      post "/categories", params: valid_attributes.to_json, headers: headers 
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq(valid_attributes[:name])
    end
  end

  describe "PUT /categories/:id" do
    it "updates the category" do
      put "/categories/#{category.id}", params: { name: "Updated Category" }.to_json, headers: headers
      expect(response).to have_http_status(:ok)
      expect(category.reload.name).to eq("Updated Category")
    end
  end

  describe "DELETE /categories/:id" do
    it "deletes the category" do
      delete "/categories/#{category.id}", headers: headers
      expect(response).to have_http_status(:no_content)
      expect(Category.exists?(category.id)).to be_falsey
    end
  end
end
