# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    member
    contract
    subscribed_at { Faker::Date.backward(14) }
  end
end
