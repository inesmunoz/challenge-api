require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { build(:product) }

  it "is valid with valid attributes" do
    expect(product).to be_valid
  end

  it "is invalid without a name" do
    product.name = nil
    expect(product).not_to be_valid
  end

  it "is invalid with negative price" do
    product.price = -10
    expect(product).not_to be_valid
  end
end
