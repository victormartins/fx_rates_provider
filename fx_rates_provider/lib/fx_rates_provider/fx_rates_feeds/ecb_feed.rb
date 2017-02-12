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
        @raw_fx_rates = parse_xml(raw_data)
        load_data
      end

      private

      attr_reader :raw_fx_rates

      def load_data
        rates_per_day.map do |rate_day|
          FXRatesCollection.new(date:      rate_day['time'],
                                source:    data_source,
                                raw_rates: parsed_rates(rate_day['Cube']))
        end
      end

      # Break dependency with outside data structure
      def data_source
        @data_source ||= raw_fx_rates['Sender'][0]['name'][0]
      end

      # Break dependency with outside data structure
      def rates_per_day
        @rates_per_day ||= raw_fx_rates['Cube'][0]['Cube']
      end

      # Break dependency with outside data structure
      def parsed_rates(raw_rate_day)
        raw_rate_day.map do |r|
          OpenStruct.new(currency: r['currency'], rate: r['rate'])
        end
      end
    end
  end
end
