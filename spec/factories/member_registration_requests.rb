# frozen_string_literal: true

FactoryBot.define do
  factory :member_registration_request do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
    email { Faker::Internet.email }
    address { Faker::Address.street_address }
    postal_code { Faker::Address.postcode }
    city { Faker::Address.city }
    step { 1 }
  end
end
