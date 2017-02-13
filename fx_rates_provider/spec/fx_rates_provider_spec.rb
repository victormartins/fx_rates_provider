require 'fx_rates_provider'

describe FXRatesProvider do
  it 'has a version number' do
    expect(FXRatesProvider::VERSION).not_to be nil
  end

  it 'has a root method' do
    expect(described_class.root).to eq(Pathname.new(Dir.pwd))
  end

  describe '.configure' do
    describe 'defaults' do
      it 'has default values' do
        expect(described_class.configuration.repository_type).to be_present
        expect(described_class.configuration.repository_name).to be_present
        expect(described_class.configuration.repository_uri).to be_present
        expect(described_class.configuration.fx_feed).to eq :ECBFeed
      end
    end

    describe 'setting new values' do
      before do
        described_class.configure do |config|
          config.repository_type = :foo
          config.repository_uri  =  URI('foo/bar')
        end
      end

      it 'allows to set new values' do
        values = {
          repository_type: :foo,
          repository_uri: URI('foo/bar')
        }

        expect(described_class.configuration).to have_attributes(values)
      end

      it 'allows to reset the configuration' do
        described_class.configuration_reset
        expect(described_class.configuration.repository_type).to eq :sqlite3

      end
    end
  end

  describe '.repository' do
    context 'with a repository active' do
      before do
        described_class.repository = :repository
      end

      it 'returns the current repository' do
        expect(described_class.repository!).to eq :repository
      end
    end

    context 'when no repository is active' do
      before do
        described_class.repository = nil
      end

      it 'raises an error' do
        expect{ described_class.repository! }.to raise_error 'No repository found!'
      end
    end
  end
end
