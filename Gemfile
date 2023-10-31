# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use internationalization in our application[https://guiarails.com.br/i18n.html]
gem 'i18n', '~> 1.12'

# A framework for creating reusable, testable & encapsulated view components,
# built to integrate seamlessly with Ruby on Rails
gem 'view_component'

# A lib that promote a Ruby on Rails application test, offering a comprehension easy sintax
# and a bigger quantity options of write and execute tests.
gem 'rspec-rails', '~> 4.0.0'

# Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/]
gem 'pg'

# Tailwind CSS is a utility-first CSS framework packed with classes like flex,
# pt-4, text-center and rotate-90 that can be composed to build any design, directly in your markup.
gem 'tailwindcss-rails', '~> 2.0'

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  # Shim to load environment variables from .env into ENV in development.
  gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
end

group :development do
  gem 'web-console'
  # Linters
  gem 'brakeman'
  gem 'erb_lint'
  # A RuboCop extension focused on enforcing Rails best practices and coding conventions.
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webdrivers'
end
