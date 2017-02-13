module FXRatesProvider
  class FXRatesCollection
    # Available Repositories for the FXRatesCollection
    module Repositories
      DEFAULT_DATE = Date.new(1900, 1, 1)
      require_relative 'repositories/sqlite3_repository'
    end
  end
end
