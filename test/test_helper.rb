ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'

require "yaml"
require "zlib"
require "multi_json"

require "minitest/autorun"
require "vcr"
require "mocha/setup"
require 'minitest/bang'

require "picasa"
require 'picasa_helper_test'

class ActiveSupport::TestCase
  include PicasaHelperTest
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  AuthHeader = ENV["PICASA_AUTH_HEADER"] || PicasaHelperTest::picasa_access_token(ENV['CODE'])
  AccessToken = ENV["PICASA_ACCESS_TOKEN"] || AuthHeader['access_token']
end
