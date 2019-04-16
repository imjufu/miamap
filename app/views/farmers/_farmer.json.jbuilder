# frozen_string_literal: true

json.extract! farmer, :id, :name, :email_address, :address, :postal_code, :city
json.url farmer_url(farmer, format: :json)
