# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fx_rates_provider/version'

Gem::Specification.new do |spec|
  spec.name          = 'fx_rates_provider'
  spec.version       = FXRatesProvider::VERSION
  spec.authors       = ['Victor Martins']
  spec.email         = ['correio@victormartins.com']

  spec.summary       = 'Library to obtain Foreign Exchange Rates'
  spec.description   = 'This library fetches foreign exchange rates through a HTTP connection. It also caches received data locally. Multiple FX providers or storate systems can be provider. '
  spec.homepage      = 'https://github.com/victormartins/fx_rates_provider'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'xml-simple', '~> 1.1.5'
  spec.add_runtime_dependency 'activemodel', '~> 5.0.1'
  spec.add_runtime_dependency 'sqlite3', '~> 1.3.13'
  spec.add_runtime_dependency 'rake', '~> 10.0'

  spec.add_development_dependency 'bundler', '~> 1.13'

  spec.add_development_dependency 'rspec', '~> 3.5'

  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'pry-doc'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'cane'
  spec.add_development_dependency 'flay'
  spec.add_development_dependency 'flog'
  spec.add_development_dependency 'inch'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'fakeweb', '~> 1.3'
  spec.add_development_dependency 'shoulda', '~> 3.5.0'
end
