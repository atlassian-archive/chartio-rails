# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chartio/version'

Gem::Specification.new do |spec|
  spec.name          = "chartio-rails"
  spec.version       = Chartio::VERSION
  spec.authors       = ["Rimas Silkaitis"]
  spec.email         = ["rimas@chartio.com"]
  spec.description   = %q{Helper functions for getting your Rails database hooked up to Chartio}
  spec.summary       = %q{Helper functions for getting your Rails database hooked up to Chartio}
  spec.homepage      = "https://chartio.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activerecord", ">= 3.0.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"
end
