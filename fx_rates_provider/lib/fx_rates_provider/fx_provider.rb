module FXRatesProvider
  # Class Responsabile to know where to get FX Rates data
  # and how to retrieve them.
  class FXProvider
    require 'fx_rates_provider/fx_rates_feeds/ecb_feed.rb'

    # Auxiliary method to make the API shorter but still benifit from
    # the internal memory of an instance object.
    def self.at(*args)
      self.new.at(*args)
    end

    # Gets data from a FX Rates Feed and saves it.
    # Rejects records with dates that are already present on the Repository
    def update!
      data = fx_feed.get
      data = remove_cached_records(data)
      data.each(&:save)
    end

    # Returns a rate between two currencies in a certain date
    def at(date, base_currency, counter_currency)
      fx_rate_collection = FXRatesCollection.repository.find_by_date(date)
      base_rate    = extract_rate(fx_rate_collection, base_currency)
      counter_rate = extract_rate(fx_rate_collection, counter_currency)

      { date: fx_rate_collection.date,
        base_rate: base_rate,
        counter_rate: counter_rate,
        source: fx_rate_collection.source
       }
    end

    # Adapter pattern so that we can easly change the repository type
    def fx_feed
      @fx_feed ||= begin
        fx_feed = FXRatesProvider.configuration.fx_feed
        raise 'Feed Adapter must be present' unless fx_feed.present?
        FXRatesProvider::FXRatesFeeds.const_get(fx_feed).new
      end
    end

    private

    def extract_rate(fx_rate_collection, target_rate)
      fx_rate_collection.fx_rates.select{ |rate| rate.currency == target_rate.to_sym }.first
    end

    def remove_cached_records(data)
      reject_date = last_updated_at
      data.reject { |fx_collection| fx_collection.date <= reject_date }
    end

    def last_updated_at
      FXRatesProvider.repository!.last_updated_at
    end

    attr_reader :repository
  end
end
