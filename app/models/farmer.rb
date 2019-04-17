# frozen_string_literal: true

class Farmer < ApplicationRecord
  acts_as_paranoid

  has_many :contracts, dependent: :destroy

  validates :name, :address, :city, presence: true
  validates :email_address, email: true
  validates :postal_code, postal_code: { country: :fr }
end
