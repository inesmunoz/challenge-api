require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { build(:product) }
  let(:user) { create(:user) }

  before do
    PaperTrail.request.whodunnit = user.id.to_s
  end

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

   it "creates a version on creation" do
    product = create(:product)
    expect(product.versions.count).to eq(1)
    expect(product.versions.last.whodunnit).to eq(user.id.to_s)
  end
  it "creates a version on update with changeset" do
    product = create(:product)
    name_before_last_save = product.name
    product.update!(name: "Updated Name")

    expect(product.versions.count).to eq(2)

    version = product.versions.last

    expect(version.event).to eq("update")
  end

end
