# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Turbolinks makes navigating your web application faster.
# Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Centralization of locale data collection for Ruby on Rails.
gem 'rails-i18n'
# Bootstrap 4 ruby gem for Ruby on Rails (Sprockets) and Hanami
# (formerly Lotus).
gem 'bootstrap', '~> 4.3.1'
# jQuery! For Rails! So great.
gem 'jquery-rails'
# Multitenancy for Rails and ActiveRecord
gem 'apartment'
# Devise is a flexible authentication solution for Rails based on Warden
gem 'devise'
gem 'devise-i18n'
# A Scope & Engine based, clean, powerful, customizable and sophisticated
# paginator for modern web app frameworks and ORMs
gem 'kaminari'
gem 'kaminari-i18n'
# ActiveRecord plugin allowing you to hide and restore records without
# actually deleting them.
gem 'paranoia'
# The authorization Gem for Ruby on Rails
gem 'cancancan'
# ActiveValidators is a collection of off-the-shelf and tested
# ActiveModel/ActiveRecord validations.
gem 'activevalidators'
# Ransack enables the creation of both simple and advanced search forms
gem 'ransack'
# A Ruby Library for dealing with money and currency conversion
gem 'money-rails'

group :development, :test do
  # Pry is a powerful alternative to the standard IRB shell
  gem 'pry-rails'
  # rspec-rails is a testing framework for Rails
  gem 'rspec-rails'
  # factory_bot is a fixtures replacement with a straightforward
  # definition syntax
  gem 'factory_bot_rails'
  # Faker is a library that generates fake data
  gem 'faker'
  # A gem providing "time travel" and "time freezing" capabilities
  gem 'timecop'
  # Library for stubbing and setting expectations on HTTP requests
  gem 'webmock'
  # Database Cleaner is a set of strategies for cleaning your database in Ruby.
  gem 'database_cleaner'
  # Call 'byebug' anywhere in the code to stop execution and get a
  # debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Preview email in the default browser instead of sending it
  gem 'letter_opener'
  # RuboCop is a Ruby static code analyzer
  gem 'rubocop-rails'
  # Access an interactive console on exception pages or by calling 'console'
  # anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in
  # the background.
  # Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
