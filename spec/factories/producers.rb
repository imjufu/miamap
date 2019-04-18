# frozen_string_literal: true

FactoryBot.define do
  factory :producer do
    name { Faker::Company.name }
    email_address { Faker::Internet.email }
    address { Faker::Address.street_address }
    postal_code { Faker::Address.postcode }
    city { Faker::Address.city }
  end
end
