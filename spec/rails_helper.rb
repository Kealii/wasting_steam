ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'simplecov'

SimpleCov.start 'rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end

def stub_omniauth
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:steam] = OmniAuth::AuthHash.new(
      {
          provider: 'steam',
          uid: '1',
          info: {
              nickname: 'Testing Steam'
          }
      }
  )
end

def login_with_bad_credentials
  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }
  OmniAuth.config.mock_auth[:steam] = nil
  OmniAuth.config.mock_auth[:steam] = :invalid_credentials
end