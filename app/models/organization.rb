# frozen_string_literal: true

class Organization < ApplicationRecord
  validates :name, :subdomain, presence: true
  validates :subdomain, uniqueness: true

  def self.host(subdomain = Apartment::Tenant.current)
    "#{subdomain}.#{ENV.fetch('DEFAULT_HOST', 'miamap.local:3000')}"
  end
end
