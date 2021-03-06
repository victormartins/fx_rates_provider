module FXRatesProvider
  # This class establishes the contract of for a Foreign Exchange Rates
  # collection.
  # This collection holds all the necessary data to give context to the FX Rates.
  class FXRatesCollection
    require_relative 'fx_rate'
    require_relative 'fx_rates_collection/repositories'
    require 'active_model'

    include ActiveModel::Model
    validates :date, :source, presence: true
    validate :fx_rates_presence

    attr_accessor :date, :source, :fx_rates

    def initialize(date:, source:, raw_rates: [])
      @date      = Date.parse(date)
      @source    = source
      @fx_rates  = []
      @raw_rates = raw_rates
      @repository = self.class.repository.new

      load_data
    end

    def save
      repository.save(self)
    end

    # Adapter pattern so that we can easly change the repository type
    def self.repository
      repository_type = FXRatesProvider.configuration.repository_type.to_s.capitalize
      raise 'Repository Adapter must be present' unless repository_type.present?
      klass = FXRatesProvider::FXRatesCollection::Repositories.const_get("#{repository_type}Repository")
      FXRatesProvider.repository = klass
    end

    private

    attr_reader :raw_rates, :repository

    def add_rate(currency:, rate:)
      @fx_rates << FXRate.new(currency, rate)
    end

    def load_data
      raw_rates.each do |raw_rate|
        add_rate(currency: raw_rate.currency,
                 rate: raw_rate.rate)
      end
    end

    def fx_rates_presence
      errors.add(:fx_rates, 'No FX Rates to save.') unless fx_rates.any?
    end
  end
end
