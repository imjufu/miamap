# frozen_string_literal: true

class Member < ApplicationRecord
  acts_as_paranoid

  validates :first_name, :last_name, :address, :city, presence: true
  validates :email_address, email: true
  validates :date_of_birth, date: {
    before: ->(_record) { Time.now.in_time_zone }
  }
  validates :postal_code, postal_code: { country: :fr }

  def full_name
    "#{first_name.capitalize} #{last_name.upcase}"
  end
end
