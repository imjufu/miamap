# frozen_string_literal: true

FactoryBot.define do
  factory :contract do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    farmer
  end
end
