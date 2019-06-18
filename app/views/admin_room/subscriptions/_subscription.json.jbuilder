# frozen_string_literal: true

json.extract! subscription, :id, :member_id, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
