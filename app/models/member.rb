# frozen_string_literal: true

class Member < ApplicationRecord
  acts_as_paranoid

  has_many :subscriptions, dependent: :destroy

  validates :first_name, :last_name, :address, :city, presence: true
  validates :email_address, email: true
  validates :date_of_birth, date: {
    before: ->(_record) { Time.now.in_time_zone }
  }
  validates :postal_code, postal_code: { country: :fr }

  ransack_alias :name, :first_name_or_last_name

  def full_name
    "#{first_name.capitalize} #{last_name.upcase}"
  end
end
