FactoryBot.define do
  factory :user do
    name { "Mario" }
    email {"matilde@gmail.com"}
    password {"password"}
    password_confirmation{ "password"}
  end

  factory :random_user, class: User do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password {"password"}
    password_confirmation{ "password"}
  end

  factory :user_login, class: User do
    name {"Michael Example" }
    email {"michael@example.com"}
    password_digest { User.digest('password') }
  end
end