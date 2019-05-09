# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    amount { Faker::Number.between(30, 50) }
    means { PaymentMeans::ALL[:check][:code] }
    payed_at { Faker::Date.backward(14) }
    subscription
  end
end
