FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 10.0..100.0) }
    after(:create) do |product|
      category = create(:category)
      create(:categorization, product: product, category: category)
    end
  end
end