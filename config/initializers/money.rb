# frozen_string_literal: true

MoneyRails.configure do |config|
  config.default_currency = :eur
  config.no_cents_if_whole = false
  config.default_format = {
    format: '%n %u'
  }
end
Money.rounding_mode = BigDecimal::ROUND_HALF_UP
Money.locale_backend = :i18n
