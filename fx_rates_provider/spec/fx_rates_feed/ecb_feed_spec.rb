require 'spec_helper'
require 'shared_examples/i_fx_rates_feed'
require 'fx_rates_provider/fx_rates_collection'
require 'fx_rates_provider/fx_rate'
require 'fx_rates_provider/fx_rates_feeds/ecb_feed'
require 'fakeweb'

describe FXRatesProvider::FXRatesFeeds::ECBFeed do
  before do
    ecb_fx_rates = File.open('spec/data/eurofxref-hist-90d.xml').read
    FakeWeb.register_uri(:get, described_class::URL, :body => ecb_fx_rates)
  end

  it_behaves_like 'a foreign exchange rates feed'

  describe '#get' do
    it 'gets fx rates for the last 90 days' do
      result = subject.get
      expect(result.count).to eq 64 # Only receiving 64 days at the moment?

      first_fxr = result.first
      expect(first_fxr.date).to eql(Date.parse('2017-02-10'))
      expect(first_fxr.source).to eql('European Central Bank')

      first_fx_rates = first_fxr.fx_rates
      expect(first_fx_rates.count).to eq 31

      expect(first_fx_rates.first.currency).to eq :USD
      expect(first_fx_rates.first.rate).to eq BigDecimal('1.0629')

      expect(first_fx_rates.last.currency).to eq :ZAR
      expect(first_fx_rates.last.rate).to eq BigDecimal('14.1866')

      last_fxr = result.last
      expect(last_fxr.date).to eql(Date.parse('2016-11-14'))
      expect(last_fxr.source).to eql('European Central Bank')

      last_fx_rates = last_fxr.fx_rates
      expect(last_fx_rates.count).to eq 31

      expect(last_fx_rates.first.currency).to eq :USD
      expect(last_fx_rates.first.rate).to eq BigDecimal('1.0777')

      expect(last_fx_rates.last.currency).to eq :ZAR
      expect(last_fx_rates.last.rate).to eq BigDecimal('15.5062')
    end
  end
end
