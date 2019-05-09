# frozen_string_literal: true

FactoryBot.define do
  factory :membership_form do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
