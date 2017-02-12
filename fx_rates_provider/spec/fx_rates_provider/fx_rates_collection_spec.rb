require 'fx_rates_provider/fx_rates_collection'
require 'shared_examples/i_fx_rates_collection'
require 'shared_examples/i_persistable'

require 'shoulda'

describe FXRatesProvider::FXRatesCollection do
  let(:date) { '2017-2-11' }
  let(:source) { 'test' }

  subject { described_class.new(date: date, source: source) }

  it_behaves_like 'a foreign exchange rates collection'

  it 'sets the repository class reference' do
    FXRatesProvider.instance_variable_set(:@repository, nil)
    expect{FXRatesProvider.repository!}.to raise_error
    subject
    expect(FXRatesProvider.repository!).to eq FXRatesProvider::FXRatesCollectionSqlite3Repository
  end

  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:source) }

    describe 'presence of rates' do
      subject { described_class.new(date: date, source: source, raw_rates: rates) }

      context 'with no rates' do
        let(:rates) { [] }

        it 'has a validation error' do
          subject.valid?
          expect(subject.errors[:fx_rates]).to include 'No FX Rates to save.'
        end
      end
    end
  end
end
