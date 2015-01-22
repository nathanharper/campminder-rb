ENV['RACK_ENV'] ||= 'test'

require 'dotenv'
Dotenv.load

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'rack/test'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'CampMinder'

require 'bundler'
Bundler.require

require File.expand_path('../dummy/config/environment', __FILE__)
