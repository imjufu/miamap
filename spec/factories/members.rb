# frozen_string_literal: true

FactoryBot.define do
  factory :member do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday(18, 65) }
    email { Faker::Internet.email }
    address { Faker::Address.street_address }
    postal_code { Faker::Address.postcode }
    city { Faker::Address.city }
    password { Faker::Internet.password(12) }
    confirmed_at { Faker::Date.backward(14) }
  end
end
