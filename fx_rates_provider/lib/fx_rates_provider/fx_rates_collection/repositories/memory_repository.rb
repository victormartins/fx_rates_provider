module FXRatesProvider
  class FXRatesCollection
    module Repositories
      # Repositories that saves data in memory only
      class MemoryRepository
        @memory = {}

        def initialize
          @memory = self.class.memory
        end

        def save(fx_collection)
          date = fx_collection.date
          memory[date.to_s.to_sym] = fx_collection
        end

        private

        attr_reader :memory

        class << self
          attr_reader :memory

          def first
            first_day_data = memory.first
            return unless first_day_data
            first_day_data[1]
          end

          def count
            @memory.inject(0) { |sum, fx_collection| sum + fx_collection[1].fx_rates.count }
          end

          def delete_all
            @memory = {}
          end

          def find_by_date(date)
            @memory[date.to_s.to_sym] if date
          end

          def last_updated_at
            first_fx_collection = first
            return DEFAULT_DATE unless first_fx_collection.present?
            first_fx_collection.date
          end
        end
      end
    end
  end
end
