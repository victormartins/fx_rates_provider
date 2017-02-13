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
    attr_accessor :repository_type, :repository_uri, :repository_name, :fx_feed

    def initialize
      @repository_type = :sqlite3
      @repository_name = 'fx_sqlite3.db'
      @repository_uri  = FXRatesProvider.root + 'repositories/'
      @fx_feed         = :ECBFeed
    end
  end

  class << self
    attr_writer :configuration, :repository

    def configuration
      @configuration ||= Configuration.new
    end

    def configuration_reset
      @configuration = Configuration.new
    end

    def repository!
      @repository || raise('No repository found!')
    end

    def configure
      yield(configuration)
    end
  end
end

# Custom class name for the client without loosing the flexibilty for
# changing namespaces in the future.
ExchangeRate = FXRatesProvider::FXProvider
