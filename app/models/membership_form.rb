# frozen_string_literal: true

class MembershipForm < ApplicationRecord
  acts_as_paranoid

  validates :title, :content, presence: true
end
