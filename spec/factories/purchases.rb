FactoryBot.define do
  factory :purchase do
    client { nil }
    product { nil }
    quantity { 1 }
    total_price { "9.99" }
  end
end
