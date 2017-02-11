# This class establishes the contract of for a Foreign Exchange Rates
# collection.
# This collection holds all the necessary data to give context to the FX Rates.
class FXRatesCollection
  require_relative 'fx_rate'
  class FXRate
    require 'bigdecimal'

    attr_reader :currency, :rate
    def initialize(currency, rate)
      @currency = currency.to_sym
      @rate     = BigDecimal.new(rate)
    end
  end

  attr_accessor :date, :source, :rates

  def initialize(date:, source:)
    @rates  = []
    @date   = Date.parse(date)
    @source = source
  end

  def add_rate(currency:, rate:)
    @rates << FXRate.new(currency, rate)
  end
end
