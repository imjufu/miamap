# frozen_string_literal: true

class Member < ApplicationRecord
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :confirmable, :lockable, :trackable,
         :recoverable, :rememberable, :validatable, :timeoutable,
         :registerable

  has_many :subscriptions, dependent: :destroy
  has_many :memberships, dependent: :destroy

  validates :first_name, :last_name, :address, :city, presence: true
  validates :date_of_birth, date: {
    before: ->(_record) { Time.now.in_time_zone }
  }
  validates :postal_code, postal_code: { country: :fr }

  ransack_alias :name, :first_name_or_last_name

  def full_name
    "#{first_name.capitalize} #{last_name.upcase}"
  end

  def to_s_for_contract
    "<strong>#{full_name}</strong><address>#{address}"\
    "<br>#{postal_code} #{city}</address>"
  end

  def self.john_doe
    new(
      first_name: 'John', last_name: 'Doe',
      address: '42 Route de Tatooine', postal_code: '69007', city: 'Lyon'
    )
  end
end
