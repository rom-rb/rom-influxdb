# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rom/influxdb/version'

Gem::Specification.new do |spec|
  spec.name          = "rom-influxdb"
  spec.version       = ROM::InfluxDB::VERSION.dup
  spec.authors       = ["Oskar Szrajer"]
  spec.email         = ["oskarszrajer@gmail.com"]
  spec.summary       = 'InfluxDB support for ROM'
  spec.description   = spec.summary
  spec.homepage      = "http://rom-rb.org"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "influxdb"
  spec.add_runtime_dependency "rom", "~> 0.6.0.beta"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
end
