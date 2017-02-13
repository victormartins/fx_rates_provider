require 'sinatra'
require 'bundler/setup'
require 'fx_rates_provider'

before do
  @default_date = Date.today
end

get '/' do
  @result = {}
  erb :index
end

post '/post' do
  date             = Date.parse(params[:date])
  base_currency    = params[:base_currency]
  counter_currency = params[:counter_currency]
  amount           = params[:amount]

  data = ExchangeRate.at(date, base_currency, counter_currency)

  if data
    base_rate    = data[:base_rate].rate
    counter_rate = data[:counter_rate].rate
    @result = {
      date:             data[:date],
      source:           data[:source],
      base_currency:    data[:base_rate].currency,
      base_rate:        base_rate.to_s('F'),
      counter_currency: data[:counter_rate].currency,
      counter_rate:     counter_rate.to_s('F'),
      result:           ((BigDecimal(amount) * base_rate)/(counter_rate)).to_s('F')
    }

  else
    @result = {}
  end
  erb :index
end
