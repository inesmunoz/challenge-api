require 'rails_helper'

RSpec.describe "Auths", type: :request do
  let!(:role) { Role.find_or_create_by!(name: "admin") }
  let!(:user) do
    User.find_by(email: "test@example.com") ||
      User.create!(
        email: "test@example.com",
        password: "123456",
        role: role
      )
end

  describe "POST /login" do
    context "valid credentials" do
      it "returns token JWT" do
        post "/login", params: { email: user.email, password: "123456" }
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)
        expect(json).to have_key("token")
        expect(json["token"]).not_to be_empty
      end
    end

    context "invalid credentials" do
      it "returns error 401" do
        post "/login", params: { email: user.email, password: "wrongpassword" }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end