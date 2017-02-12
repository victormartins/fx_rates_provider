module FXRatesProvider
  # Class Responsabile to know where to get FX Rates data
  # and how to retrieve them.
  class FXProvider
    require 'fx_rates_provider/fx_rates_feeds/ecb_feed.rb'

    def initialize(fx_feed = FXRatesFeeds::ECBFeed.new)
      @fx_feed = fx_feed
    end

    # Gets data from a FX Rates Feed and saves it.
    def update!
      data = fx_feed.get
      data.collect(&:save)
    end

    private

    attr_reader :fx_feed
  end
end
