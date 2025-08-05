FactoryBot.define do
  factory :purchase do
    association :product
    association :client
    quantity { 1 }
    total_price { "9.99" }
  end
end