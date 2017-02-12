require 'fx_rates_provider'

describe FXRatesProvider do
  it 'has a version number' do
    expect(FXRatesProvider::VERSION).not_to be nil
  end

  describe '.configure' do
    describe 'defaults' do
      it 'has default values' do
        defaults = {
          repository_type: :sqlite3
        }
        expect(described_class.configuration).to have_attributes(defaults)
      end
    end

    describe 'setting new values' do
      before do
        described_class.configure do |config|
          config.repository_type = :foo
        end
      end

      it 'allows to set new values' do
        values = {
          repository_type: :foo
        }

        expect(described_class.configuration).to have_attributes(values)
      end
    end
  end
end
