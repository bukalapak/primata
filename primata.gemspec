# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'primata/version'

Gem::Specification.new do |spec|
  spec.name          = "primata"
  spec.version       = Primata::VERSION
  spec.authors       = ["Alif Rachmawadi"]
  spec.email         = ["subosito@gmail.com"]
  spec.summary       = %q{Commonly used logic in Bukalapak}
  spec.description   = %q{...}
  spec.homepage      = "https://github.com/bukalapak/primata"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "simplecov", "~> 0.11"
  spec.add_development_dependency "webmock", "~> 1.18"

  spec.add_dependency "phonelib", "~> 0.6.2"
  spec.add_dependency "twilio-ruby", ">= 3.11.4"
end
