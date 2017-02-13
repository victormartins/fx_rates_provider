require 'fx_rates_provider'
require 'fx_rates_provider/fx_provider'
require 'fx_rates_provider/fx_rates_collection_sqlite3_repository'

describe FXRatesProvider::FXProvider do
  describe '#at' do
    before do
      # load fx rates
      subject.update!
    end

    it 'returns a rate for a given date when it finds one' do
      date = Date.new(2017, 2, 8)
      result = subject.at(date, 'GBP', 'USD')


      expect(result[:date]).to eq date
      expect(result[:source]).to eq 'European Central Bank'

      expect(result[:base_rate].currency).to eq :GBP
      expect(result[:base_rate].rate).to eq BigDecimal.new('0.85315E0')

      expect(result[:counter_rate].currency).to eq :USD
      expect(result[:counter_rate].rate).to eq BigDecimal.new('0.10665E1')
    end
  end
end
