# frozen_string_literal: true

json.extract! contract, :id, :title, :content, :created_at, :updated_at
json.url contract_url(contract, format: :json)
