require 'dotenv'
Dotenv.load

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'CampMinder'

puts "CampMinder::BUSINESS_PARTNER_ID: #{CampMinder::BUSINESS_PARTNER_ID}"
