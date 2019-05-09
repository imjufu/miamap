# frozen_string_literal: true

MoneyRails.configure do |config|
  config.default_currency = :eur
  config.no_cents_if_whole = false
  config.default_format = {
    format: '%n %u'
  }
end
