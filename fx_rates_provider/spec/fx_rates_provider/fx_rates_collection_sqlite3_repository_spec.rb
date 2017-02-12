require 'fx_rates_provider/fx_rates_collection_sqlite3_repository'
require 'shared_examples/i_repository'

describe FXRatesProvider::FXRatesCollectionSqlite3Repository do
  subject { described_class.new([]) }

  it_behaves_like 'a repository class'
end
