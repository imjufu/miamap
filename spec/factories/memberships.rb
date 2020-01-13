# frozen_string_literal: true

FactoryBot.define do
  factory :membership do
    membership_form
    member
    membershiped_at { Faker::Date.backward(days: 14) }
  end
end
