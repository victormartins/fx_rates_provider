module FXRatesProvider
  class FXRatesCollection
    # Class that represents a Currency Rate
    class FXRate
      require 'bigdecimal'

      attr_reader :currency, :rate
      def initialize(currency, rate)
        @currency = currency.to_sym
        @rate     = BigDecimal.new(rate)
      end
    end
  end
end
