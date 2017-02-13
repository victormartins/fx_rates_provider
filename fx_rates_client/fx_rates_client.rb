require 'sinatra'
require 'bundler/setup'
require 'fx_rates_provider'

get '/' do
  rates = ExchangeRate.at(Date.today, 'GBP', 'USD')
end
