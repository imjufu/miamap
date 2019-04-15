# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :registerable and :omniauthable
  devise :database_authenticatable, :confirmable, :lockable, :trackable,
         :recoverable, :rememberable, :validatable, :timeoutable

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name.capitalize} #{last_name.upcase}"
  end
end
