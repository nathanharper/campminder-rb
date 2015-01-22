require 'virtus'

module CampMinder
end

Dir[File.dirname(__FILE__) + '/CampMinder/**/*.rb'].each {|file| require file }
