module FXRatesProvider
  class FXRatesCollection
    # Available Repositories for the FXRatesCollection
    module Repositories
      require_relative 'repositories/sqlite3_repository'
    end
  end
end
