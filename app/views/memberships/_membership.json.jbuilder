# frozen_string_literal: true

json.extract! membership, :id, :title, :created_at, :updated_at
json.url membership_url(membership, format: :json)
