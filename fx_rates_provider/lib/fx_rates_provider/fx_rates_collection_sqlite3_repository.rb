module FXRatesProvider
  class FXRatesCollectionSqlite3Repository
    require "sqlite3"

    DB_TABLE_NAME = :fx_rates

    def save(collection)
      sql = "INSERT INTO '#{DB_TABLE_NAME}' ('date', 'source', 'currency', 'rate') VALUES\n"
      fx_rates = collection.fx_rates

      fx_rates.each_with_index do |fx_rate, index|
        sql << "\t('#{collection.date}', '#{collection.source}', '#{fx_rate.currency}', '#{fx_rate.rate}')"
        sql << ",\n" unless index == fx_rates.count - 1
      end
      sql << ';'

      self.class.db.execute(sql)
    end

    class << self
      def find_by_date(date)
        sql = "SELECT * from #{DB_TABLE_NAME} WHERE date = '#{date}'"
        data = db.execute(sql)
        return if data.empty?
        convert_to_fx_collection(data)
      end

      # The date of the last entry
      def last_updated_at
        first_record = self.first
        return Date.new(1900, 1, 1) unless first_record

        first_record.date
      end

      def first
        sql = "SELECT * from #{DB_TABLE_NAME} WHERE "
        sql << "date = (SELECT date from #{DB_TABLE_NAME} ORDER BY id LIMIT 1)"
        data = db.execute(sql)

        return unless data.any?
        convert_to_fx_collection(data)
      end

      def delete_all
        sql = "DELETE FROM #{DB_TABLE_NAME};"
        sql << "DELETE FROM SQLITE_SEQUENCE WHERE name='#{DB_TABLE_NAME}';"
        db.execute(sql)
      end

      def count
        sql = "SELECT COUNT(*) FROM #{DB_TABLE_NAME}"
        result = db.execute(sql)
        return unless result
        result.flatten.first
      end

      def db
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

      def convert_to_fx_collection(data)
        date      = data.first[-1]
        source    = data.first[1]
        raw_rates = data.collect{ |d| OpenStruct.new(currency: d[2], rate: d[3].to_s) }

        FXRatesProvider::FXRatesCollection.new(date: date, source: source, raw_rates: raw_rates)
      end

    end

    private_class_method :convert_to_fx_collection
  end
end
