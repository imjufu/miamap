# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :registerable and :omniauthable
  devise :database_authenticatable, :confirmable, :lockable, :trackable,
         :recoverable, :rememberable, :validatable, :timeoutable
end
