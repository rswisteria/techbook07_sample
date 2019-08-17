FactoryBot.define do
  factory :user do
    name { "Kanade Hayami" }
    email { "kanade@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end