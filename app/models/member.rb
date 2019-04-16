# frozen_string_literal: true

class Member < ApplicationRecord
  acts_as_paranoid

  validates :first_name, :last_name, :address, :city, presence: true
  validates :email_address, email: true
  validates :date_of_birth, date: true
  validates :postal_code, postal_code: { country: :fr }
end
