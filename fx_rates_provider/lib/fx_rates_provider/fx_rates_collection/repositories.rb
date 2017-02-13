module FXRatesProvider
  class FXRatesCollection
    # Available Repositories for the FXRatesCollection
    module Repositories
      require_relative 'repositories/sqlite3_repository'
      require_relative 'repositories/memory_repository'

      DEFAULT_DATE = Date.new(1900, 1, 1)
    end
  end
end
