# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simplewoo/version'

Gem::Specification.new do |spec|
    spec.name          = "simplewoo"
    spec.version       = Simplewoo::VERSION
    spec.authors       = ["Jason Truluck", "Carson Wright", "Tom Prats", "Sam Boyd", "Chris Preisinger"]
    spec.email         = ["jason.truluck@gmail.com", "carsonnwright@gmail.com", "tom@tomprats.com", "sam@woofound.com", "chris@woofound.com"]
    spec.description   = %q{Woofound Client Gem}
    spec.summary       = spec.description
    spec.homepage      = ""
    spec.license       = "MIT"

    spec.files         = `git ls-files`.split($/)
    spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
    spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
    spec.require_paths = ["lib"]

    spec.add_dependency "faraday", "~> 0.8.0"
    spec.add_dependency "faraday_middleware", "~> 0.9.0"
    spec.add_dependency "hashie", "~> 2.0.0"
    spec.add_dependency "multi_json", "~> 1.8.0"

    spec.add_development_dependency "bundler", "~> 1.3"
    spec.add_development_dependency "rake", "~> 10.1.0"
    spec.add_development_dependency "rspec", "~> 2.14.0"
    spec.add_development_dependency "pry"
    spec.add_development_dependency "binding_of_caller"
    spec.add_development_dependency "webmock", "~> 1.13.0"
    spec.add_development_dependency "simplecov", "~> 0.7.0"
    spec.add_development_dependency "coveralls", "~> 0.7.0"
    spec.add_development_dependency "yard", "~> 0.8.0.0"
    spec.add_development_dependency "redcarpet", "~> 3.0.0"
end

