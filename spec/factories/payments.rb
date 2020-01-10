# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    amount { Faker::Number.between(from: 30, to: 50) }
    means { PaymentMeans::ALL[:check][:code] }
    payed_at { Faker::Date.backward(days: 14) }
    subscription
  end
end
