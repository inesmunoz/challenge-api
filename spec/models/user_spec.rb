require 'rails_helper'

RSpec.describe User, type: :model do
  let(:role) { Role.find_or_create_by!(name: "admin") }

  it "is valid with email and password" do
    user = User.new(email: "test_1@example.com", password: "123456", role:)
    expect(user).to be_valid
  end

  it "invalid without email" do
    user = User.new(password: "123456", role:)
    expect(user).not_to be_valid
  end

  it "invalid without password" do
    user = User.new(email: "test_2@example.com", role:)
    expect(user).not_to be_valid
  end

  it "authenticate with the correct password" do
    user = User.create!(email: "auth_1@example.com", password: "secret", role:)
    expect(user.authenticate("secret")).to eq(user)
  end

  it "authentication fails with incorrect password" do
    user = User.create!(email: "auth_2@example.com", password: "secret", role:)
    expect(user.authenticate("mala")).to be_falsey
  end
end
