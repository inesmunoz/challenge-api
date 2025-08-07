require 'rails_helper'

RSpec.describe Categorization, type: :model do
  let(:categorization) { build(:categorization) }

  it "is valid with valid attributes" do
    expect(categorization).to be_valid
  end

  it "is invalid without product" do
    categorization.product = nil
    expect(categorization).not_to be_valid
  end

  it "is invalid without category" do
    categorization.category = nil
    expect(categorization).not_to be_valid
  end
end
