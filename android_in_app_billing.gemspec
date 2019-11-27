# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'android_in_app_billing/version'

Gem::Specification.new do |spec|
  spec.name          = "android_in_app_billing"
  spec.version       = AndroidInAppBilling::VERSION
  spec.authors       = ["dkrasnov"]
  spec.email         = ["dkrasnov@spbtv.com"]

  spec.summary       = %q{A toolkit to work with android in-app purchases}
  spec.description   = %q{Implements in-app purchase data parsing, signature validation, }
  spec.homepage      = "https://github.com/SPBTV/android_in_app_billing"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'google-api-client', '~> 0.34.1'
  spec.add_runtime_dependency 'dry-configurable', '~> 0.7'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'factory_girl', '~> 4.0'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 3.0'
  spec.add_development_dependency 'pry'
end
