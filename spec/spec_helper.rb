require 'simplecov'
SimpleCov.start

require 'codecov'
require 'webmock/rspec'
require 'primata'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Codecov
]
