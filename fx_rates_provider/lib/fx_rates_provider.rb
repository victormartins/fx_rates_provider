require 'fx_rates_provider/version'

# Main Module
module FXRatesProvider
  require 'fx_rates_provider/fx_rates_collection'
  require 'fx_rates_provider/fx_rate'
  require 'fx_rates_provider/fx_provider'

  def self.root
    Pathname(__FILE__).dirname.parent
  end

  class Configuration
    attr_accessor :repository_type, :repository_uri

    def initialize
      @repository_type = :sqlite3
      @repository_uri = FXRatesProvider.root + 'repositories' + 'fx_sqlite3.db'
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
