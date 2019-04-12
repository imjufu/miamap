# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Miamap
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified
    # here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Whitelist locales available for the application
    config.i18n.default_locale = :fr

    # With a configured (default) time zone:
    #   * ActiveRecord writes UTC to the database
    #   * ActiveRecord converts time attributes back to the configured default
    #     time zone
    #   * ActiveRecord time attributes are ActiveSupport::TimeWithZone objects
    #   * Time.current will be in the configured default time zone
    #   * Time.now will be your local time (or the local time of your server)
    config.time_zone = 'Paris'

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
