task coin_market_cap: :environment do
  ::Generators::Currency.run
  ::Generators::Snapshot.run
end
