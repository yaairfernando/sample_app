FactoryBot.define do
  factory :post do
    body { "This is my first post" }
    user_id { 1 }
  end
end