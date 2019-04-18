# frozen_string_literal: true

json.extract! producer, :id, :name, :email_address, :address,
              :postal_code, :city
json.url producer_url(producer, format: :json)
