require 'rails_helper'

RSpec.describe Client, type: :model do
  let(:client) { build(:client) }

  it "is valid with valid attributes" do
    expect(client).to be_valid
  end

  it "is invalid without a name" do
    client.name = nil
    expect(client).not_to be_valid
  end

  it "is invalid without an email" do
    client.email = nil
    expect(client).not_to be_valid
  end

  it "is invalid with duplicate email" do
    create(:client, email: "duplicate@example.com")
    client.email = "duplicate@example.com"
    expect(client).not_to be_valid
  end
end