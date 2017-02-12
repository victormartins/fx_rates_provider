require 'fx_rates_provider/version'

# Main Module
module FXRatesProvider
  require 'fx_rates_provider/fx_rates_collection'
  require 'fx_rates_provider/fx_rate'
  require 'fx_rates_provider/fx_provider'

  class Configuration
    attr_accessor :repository_type

    def initialize
      @repository_type = :sqlite3
    end
  end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end

# Custom class name for the client without loosing the flexibilty for
# changing namespaces in the future.
ExchangeRate = FXRatesProvider::FXProvider
