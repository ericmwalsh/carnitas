require_relative '../../app/workers/coin_market_cap_worker'

task :coin_market_cap do
  ::Generators::Currency.run
  ::Generators::Snapshot.run
end
