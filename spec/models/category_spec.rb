require 'rails_helper'


RSpec.describe Category, type: :model do
  let(:category) { build(:category) }

  it "is valid with valid attributes" do
    expect(category).to be_valid
  end

  it "is invalid without a name" do
    category.name = nil
    expect(category).not_to be_valid
  end
end