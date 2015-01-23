ENV['RACK_ENV'] ||= 'test'

require 'dotenv'
Dotenv.load

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rack/test'
require 'timecop'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'CampMinder'

require 'bundler'
Bundler.require

require File.expand_path('../dummy/config/environment', __FILE__)

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f }

RSpec.configure do |config|
  config.include CampMinderSpecs
end
