$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry-byebug'
require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'fx_rates_provider'
FXRatesProvider.configure do |config|
  config.repository_name = 'fx_sqlite3_test.db'
end
