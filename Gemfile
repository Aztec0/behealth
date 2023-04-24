# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4', '>= 7.0.4.2'

gem 'active_model_serializers'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

gem 'net-imap', require: false
gem 'net-pop', require: false
gem 'net-smtp', require: false

# Jwt for token auth
gem 'jwt'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', require: 'rack/cors'

# gem 'figaro'

# To build a simple, robust and scalable authorization system
gem 'pundit', '~> 2.3'

# Ransack will help you easily add searching to your Rails application, without any additional dependencies
gem 'ransack'

# Rswag extends rspec-rails "request specs" with a Swagger-based DSL for describing and testing API operations
gem 'rswag-api'
gem 'rswag-ui'

# Tools for developing Telegram bots.
gem 'telegram-bot-ruby'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  # Add a comment summarizing the current schema to the top or bottom of each of your need
  gem 'annotate'

  # Byebug is a simple to use and feature rich debugger for Ruby
  gem 'byebug'

  # It's a library for generating fake data such as names, addresses, and phone numbers
  gem 'faker'

  # Preview email in the default browser instead of sending it
  gem 'letter_opener'

  # Rswag extends rspec-rails "request specs" with a Swagger-based DSL for describing and testing API operations
  gem 'rspec-rails'
  gem 'rswag-specs'

  # A RuboCop extension focused on enforcing Rails best practices and coding conventions
  gem 'rubocop', '~> 1.40', require: false
  gem 'rubocop-performance', '~> 1.15', require: false
  gem 'rubocop-rails', '~> 2.17', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  # gem 'pagy'
  # For deploying on a server
  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-nginx'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-upload-config'
  gem 'sshkit-sudo'
end
