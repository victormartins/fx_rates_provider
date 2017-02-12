# This class establishes the contract of for a Foreign Exchange Rates
# collection.
# This collection holds all the necessary data to give context to the FX Rates.
class FXRatesCollection
  require_relative 'fx_rate'

  attr_accessor :date, :source, :fx_rates

  def initialize(date:, source:, raw_rates: [])
    @date      = Date.parse(date)
    @source    = source
    @fx_rates  = []
    @raw_rates = raw_rates

    load_data
  end

  private

  attr_reader :raw_rates
  def add_rate(currency:, rate:)
    @fx_rates << FXRate.new(currency, rate)
  end

  def load_data
    raw_rates.each do |raw_rate|
      add_rate(currency: raw_rate.currency,
               rate: raw_rate.rate)
    end
  end
end
