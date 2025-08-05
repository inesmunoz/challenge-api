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

    it "creates a version on update with changeset" do
    category = create(:category)
    name_before_last_save = category.name
    category.update!(name: "Updated Name")

    expect(category.versions.count).to eq(2)

    version = category.versions.last

    expect(version.event).to eq("update")
  end
end