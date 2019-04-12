# frozen_string_literal: true

class Organization < ApplicationRecord
  validates :name, :subdomain, presence: true
  validates :subdomain, uniqueness: true
end
