# frozen_string_literal: true

class Subscription < ApplicationRecord
  acts_as_paranoid

  belongs_to :member
  belongs_to :contract

  validates :member_accepted_at, date: true, allow_nil: true
  validates :producer_accepted_at, date: true, allow_nil: true
  validates :subscribed_at, date: true
end
