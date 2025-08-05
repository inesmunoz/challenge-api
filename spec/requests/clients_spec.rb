require 'rails_helper'

RSpec.describe "Clients API", type: :request do
  let!(:client) { create(:client) }
  let(:user) { create(:user) }
  let(:token) { generate_token(user) } # Usa tu método para generar JWT

  let(:valid_attributes) { attributes_for(:client) }

  let(:headers) do
    {
      "Authorization" => "Bearer #{token}",
      "Content-Type" => "application/json"
    }
  end

  describe "GET /clients" do
    it "returns all clients" do
      get "/clients", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).not_to be_empty
    end
  end

  describe "GET /clients/:id" do
    it "returns the client" do
      get "/clients/#{client.id}", headers: headers
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["id"]).to eq(client.id)
    end
  end

  describe "POST /clients" do
    it "creates a new client" do
      post "/clients", params: valid_attributes.to_json, headers: headers
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["name"]).to eq(valid_attributes[:name])
    end
  end

  describe "PUT /clients/:id" do
    it "updates the client" do
      put "/clients/#{client.id}", params: { name: "Updated Client" }.to_json, headers: headers
      expect(response).to have_http_status(:ok)
      expect(client.reload.name).to eq("Updated Client")
    end
  end

  describe "DELETE /clients/:id" do
    it "deletes the client" do
      delete "/clients/#{client.id}", headers: headers
      expect(response).to have_http_status(:no_content)
      expect(Client.exists?(client.id)).to be_falsey
    end
  end
end
