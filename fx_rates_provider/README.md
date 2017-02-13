# FxTradesProvider


## Installation

```ruby
gem 'fx_trades_provider'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fx_trades_provider

## Configuration and default values

```
  FXRatesProvider.configure |config|
    config.repository_type = :sqlite3
    config.repository_uri = <gem_root_path>/repositories/fx_sqlite3.db
    config.fx_feed = :ECBFeed
  end
```

## Usage

To update the repository with the latest Foreign Exchange Rates call the following rake task.
Note: This will not save previously saved rates.

```
rake fx_feed:update!
```

To use the FXRatesProvider::FXProvider
fx_provider = FXRatesProvider::FXProvider.new

#Updates the repository with new fx rates from the configurated feed
fx_provider.update!

#Returns a FXRatesProvider::FXRatesCollection with both fx rates for the given date
fx_provider.at(Date.current, 'GBP', 'USD')

#Development

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
