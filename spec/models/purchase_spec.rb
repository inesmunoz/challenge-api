require 'rails_helper'

RSpec.describe Purchase, type: :model do
  # Crear datos con factories
  let(:product) { create(:product) }
  let(:client) { create(:client) }
  let(:purchase) { build(:purchase, product: product, client: client) }

  it "is valid with valid attributes" do
    expect(purchase).to be_valid
  end

  it "belongs to a product" do
    expect(purchase.product).to eq(product)
  end

  it "belongs to a client" do
    expect(purchase.client).to eq(client)
  end
end
