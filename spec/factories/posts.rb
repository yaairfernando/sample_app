FactoryBot.define do
  factory :post do
    body { "This is my first post" }
    user_id { 1 }
  end

  factory :random_post, class: Post do
    body { Faker::Lorem }
    user_id { Faker::Number.unique}
  end
end