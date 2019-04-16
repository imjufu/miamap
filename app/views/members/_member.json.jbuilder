# frozen_string_literal: true

json.extract! member, :id, :first_name, :last_name, :email_address, :address,
              :postal_code, :city
json.url member_url(member, format: :json)
