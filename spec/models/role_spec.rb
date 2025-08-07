require 'rails_helper'

RSpec.describe Role, type: :model do
  it "is valid with a name" do
    role = Role.new(name: "user")
    expect(role).to be_valid
  end
end
