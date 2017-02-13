require 'fx_rates_provider'
require 'fx_rates_provider/fx_provider'
require 'fx_rates_provider/fx_rates_collection_sqlite3_repository'

describe FXRatesProvider::FXProvider do
  describe '#update!' do
    describe 'getting and saving data' do
      subject { described_class.new }

      after :each do
        repository.delete_all
      end

      let(:repository) { FXRatesProvider::FXRatesCollectionSqlite3Repository }
      let(:fx_data) { FXRatesProvider::FXRatesFeeds::ECBFeed.new.get }
      let(:fx_total) { fx_data.count * fx_data.first.fx_rates.count }

      it 'gets fx rates and saves them in the persistence system' do
        subject.update!
        first = repository.first

        expected_first = fx_data.first
        expect(first.date).to eq expected_first.date
        expect(first.source).to eq expected_first.source
        expect(first.fx_rates.count).to eq expected_first.fx_rates.count

        expect(repository.count).to eq(fx_total)
      end

      it 'does not update the same values twice' do
        subject.update!
        expect(repository.count).to eq(fx_total)
        subject.update!
        expect(repository.count).to eq(fx_total)
      end
    end

    describe 'rejecting rates of dates already inserted' do
      let(:feed_mock) { instance_double 'FXRatesProvider::FXRatesFeeds::ECBFeed' }
      let(:repository_mock) { class_double 'FXRatesProvider::FXRatesCollectionSqlite3Repository' }

      subject { described_class.new }
      let(:yesterday) { Date.today.prev_day }
      let(:fx_rate_1) { double(:fx_rate_1, date: Date.today) }
      let(:fx_rate_2) { double :fx_rate_2, date: yesterday }
      let(:feed_data) { [fx_rate_1, fx_rate_2] }

      before do
        FXRatesProvider.repository = repository_mock
        expect(subject).to receive(:fx_feed).and_return(feed_mock)
        expect(repository_mock).to receive(:last_updated_at).and_return(yesterday)
        expect(feed_mock).to receive(:get).and_return(feed_data)
      end

      it 'rejects rates with a date lower than the last updated date' do
        expect(fx_rate_1).to receive(:save)
        expect(fx_rate_2).to_not receive(:save)
        subject.update!
      end
    end
  end
end
