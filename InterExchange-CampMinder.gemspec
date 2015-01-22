# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'InterExchange/CampMinder/version'

Gem::Specification.new do |spec|
  spec.name          = "InterExchange-CampMinder"
  spec.version       = InterExchange::CampMinder::VERSION
  spec.authors       = ["Dirk Kelly"]
  spec.email         = ["iex-eng+dirkkelly@googlegroups.com"]
  spec.summary       = %q{Interface InterExchange for CampMinder ClientLink API.}
  spec.homepage      = "https://github.com/interexchange/campminder-rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
end