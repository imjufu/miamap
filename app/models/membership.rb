# frozen_string_literal: true

class Membership < ApplicationRecord
  acts_as_paranoid

  belongs_to :membership_form
  belongs_to :member

  validates :member_accepted_at, date: true, allow_nil: true
  validates :membershiped_at, date: true
end
