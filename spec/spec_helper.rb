require 'dotenv'
puts Dotenv.load

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'CampMinder'
