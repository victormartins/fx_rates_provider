module FXRatesProvider
  class FXRatesCollectionSqlite3Repository
    require "sqlite3"

    DB_TABLE_NAME = :fx_rates

    def initialize(fx_rates_collection)
      @collection = fx_rates_collection
    end

    def save
      # if collection_valid
      sql = "INSERT INTO '#{DB_TABLE_NAME}' ('date', 'source', 'currency', 'rate') VALUES\n"
      fx_rates = collection.fx_rates
      fx_rates.each_with_index do |fx_rate, index|
        sql << "\t('#{collection.date}', '#{collection.source}', '#{fx_rate.currency}', '#{fx_rate.rate}')"
        sql << ",\n" unless index == fx_rates.count - 1
      end
      sql << ';'

      self.class.db.execute(sql)
    end

    private

    attr_reader :collection

    def self.first
      sql = "SELECT * from #{DB_TABLE_NAME} WHERE "
      sql << "date = (SELECT date from #{DB_TABLE_NAME} LIMIT 1)"
      data = db.execute(sql)

      return [] unless data.any?

      date      = data.first[-1]
      source    = data.first[1]
      raw_rates = data.collect{ |d| OpenStruct.new(currency: d[2], rate: d[3].to_s) }

      FXRatesProvider::FXRatesCollection.new(date: date, source: source, raw_rates: raw_rates)
    end

    def self.delete_all
      sql = "DELETE FROM #{DB_TABLE_NAME};"
      sql << "DELETE FROM SQLITE_SEQUENCE WHERE name='#{DB_TABLE_NAME}';"
      db.execute(sql)
    end

    def self.db
      @db ||= begin
        repository_uri = FXRatesProvider.configuration.repository_uri

        SQLite3::Database.new(repository_uri.to_s).tap do |db|
          db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS #{DB_TABLE_NAME} (
              id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
              source VARCHAR(255),
              currency VARCHAR(3),
              rate     DECIMAL(8,2),
              date     DATE
            );
          SQL
        end
      end
    end
  end
end
