FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 1..100.0) }
    product_type { "Physical" }  # o el que uses en tu modelo
  end
end