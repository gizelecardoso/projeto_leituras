# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Rails 7.1: Uses broader parameter filters to prevent sensitive data from appearing in logs.
Rails.application.config.filter_parameters += [
  :passw, :secret, :token, :_key, :crypt, :salt, :certificate, :otp, :ssn
]
