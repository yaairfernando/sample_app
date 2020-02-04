factory :post do |f|
  f.body { Faker::Name.body }
end

factory :invalid_post, parent: :post do |f|
  f.body nil
end 