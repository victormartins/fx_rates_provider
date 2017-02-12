require 'fx_rates_provider'
require 'fx_rates_provider/fx_provider'
require 'fx_rates_provider/fx_rates_collection_sqlite3_repository'
require 'support/xml_parser.rb'


describe FXRatesProvider::FXProvider do
  include XMLParser
  let(:repository) { FXRatesProvider::FXRatesCollectionSqlite3Repository }
  subject{described_class.new}

  describe '#update!' do
    after :each do
      repository.delete_all
    end

    let(:fx_data) { FXRatesProvider::FXRatesFeeds::ECBFeed.new.get }

    it 'gets fx rates and saves them in the persistence system' do
      subject.update!
      first = repository.first

      expected_first = fx_data.first
      expect(first.date).to eq expected_first.date
      expect(first.source).to eq expected_first.source
      expect(first.fx_rates.count).to eq expected_first.fx_rates.count
    end
  end
end
