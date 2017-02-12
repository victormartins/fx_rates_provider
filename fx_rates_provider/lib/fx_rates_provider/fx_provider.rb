module FXRatesProvider
  # Class Responsabile to know where to get FX Rates data
  # and how to retrieve them.
  class FXProvider
    require 'fx_rates_provider/fx_rates_feeds/ecb_feed.rb'

    def initialize(fx_feed = FXRatesFeeds::ECBFeed.new)
      @fx_feed = fx_feed
    end

    # Gets data from a FX Rates Feed and saves it.
    # Rejects records with dates that are already present on the Repository
    def update!
      data = fx_feed.get
      data = remove_cached_records(data)
      data.collect(&:save)
    end

    private

    def remove_cached_records(data)
      reject_date = last_updated_at
      data.reject { |fx_collection| fx_collection.date <= reject_date }
    end

    def last_updated_at
      FXRatesProvider.repository!.last_updated_at
    end

    attr_reader :fx_feed
  end
end
