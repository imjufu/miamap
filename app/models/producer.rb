# frozen_string_literal: true

class Producer < ApplicationRecord
  acts_as_paranoid

  has_many :contracts, dependent: :destroy

  validates :name, :address, :city, presence: true
  validates :email_address, email: true
  validates :postal_code, postal_code: { country: :fr }

  def to_s_for_contract
    "<strong>#{name}</strong><address>#{address}"\
    "<br>#{postal_code} #{city}</address>"
  end
end
