# frozen_string_literal: true

FactoryBot.define do
  factory :farmer do
    name { Faker::Company.name }
    address { Faker::Address.street_address }
    postal_code { Faker::Address.postcode }
    city { Faker::Address.city }
  end
end
