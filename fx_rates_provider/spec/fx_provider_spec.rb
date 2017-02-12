require 'fx_rates_provider/fx_provider'
require 'fx_rates_provider/fx_rates_collection_file_repository'

describe FXRatesProvider::FXProvider do
  subject{described_class.new}

  describe '#update' do
    it 'gets fx rates and saves them in the persistence system' do
      subject.update!
      expect(FXRatesCollectionFileRepository.first).to eq :the_first_of_the_feed
    end
  end
end
