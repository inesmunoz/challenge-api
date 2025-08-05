require 'rails_helper'

RSpec.describe Image, type: :model do
  it "is valid with valid attributes" do
    image = build(:image)
    expect(image).to be_valid
  end

  it "is invalid without an attached file" do
    image = build(:image)
    image.file.detach
    expect(image).not_to be_valid
    expect(image.errors[:file]).to include("can't be blank")
  end
end