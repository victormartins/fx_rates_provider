require 'fx_rates_provider/fx_rates_collection/repositories/sqlite3_repository'
require 'shared_examples/i_repository'

describe FXRatesProvider::FXRatesCollection::Repositories::Sqlite3Repository do
  subject { described_class.new }

  it_behaves_like 'a repository class'
end
