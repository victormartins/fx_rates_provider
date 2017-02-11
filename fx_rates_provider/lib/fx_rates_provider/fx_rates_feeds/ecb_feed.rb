module FXRatesProvider
  module FXRatesFeeds
    # Feed from the European Central Bank
    class ECBFeed
      require 'support/http_connection'
      require 'support/xml_parser'
      include HTTPConnection
      include XMLParser

      URL = URI('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml')

      def get
        raw_data = http_get(URL)
        raw_fx_rates = parse_xml(raw_data)
        load_data(raw_fx_rates)
      end

      private

      def load_data(raw_fx_rates)
        result = []
        source = raw_fx_rates['Sender'][0]['name'][0]
        rates_per_day = raw_fx_rates['Cube'][0]['Cube']

        rates_per_day.each do |rate_day|
          date = rate_day['time']
          collection = FXRatesCollection.new(date: date, source: source)

          rates = rate_day['Cube']
          rates.each do |data|
            collection.add_rate(currency: data['currency'], rate: data['rate'])
          end
          result << collection
        end

        result
      end
    end
  end
end
