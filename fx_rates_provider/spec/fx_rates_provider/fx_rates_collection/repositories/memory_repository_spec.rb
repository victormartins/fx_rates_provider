require 'fx_rates_provider/fx_rates_collection/repositories/memory_repository'
require 'shared_examples/i_repository'

describe FXRatesProvider::FXRatesCollection::Repositories::MemoryRepository do
  subject { described_class.new }

  it_behaves_like 'a repository class'
end
