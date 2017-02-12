class FXRatesCollectionSqlite3Repository
  require "sqlite3"

  DB_NAME =

  def initialize(fx_rates_collection)
    @collection = fx_rates_collection
    # Create a table
    rows = db.execute <<-SQL
      create table numbers (
        name varchar(30),
        val int
      );
    SQL
  end

  # Setups the repository
  def self.setup!
  end

  def self.first
  end

  def save
  end

  private

  def self.db
    @db ||= SQLite3::Database.new 'fx_sqlite3.db'
  end

  private_class_method :db
end
