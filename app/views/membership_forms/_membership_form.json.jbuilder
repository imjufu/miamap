# frozen_string_literal: true

json.extract! membership_form, :id, :title, :content
json.url membership_form_url(membership_form, format: :json)
