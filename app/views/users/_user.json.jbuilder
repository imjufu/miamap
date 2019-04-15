# frozen_string_literal: true

json.extract! user, :id, :email, :first_name, :last_name, :password
json.url user_url(user, format: :json)
