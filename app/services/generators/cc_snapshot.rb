# ::Generators::Snapshot
module Generators
  class CcSnapshot < ::Generators::Base
    class << self

      def run
        currencies = ::Currency.distinct.pluck(:symbol)
        currencies.in_groups_of(25, false).each do |group|
          group.each do |symbol|
            snapshots = ::Generators::Providers::CryptoCompare.snapshots(symbol == 'MIOTA' ? 'IOTA' : symbol)
            if snapshots.present?
              new_snapshots = []
              timestamps = []

              # format snapshots
              existings_snapshots = ::CcSnapshot.where(
                symbol: symbol,
                time: snapshots.map {|snapshot| snapshot['time']}
              )
              snapshots.each do |snapshot|
                exists = existings_snapshots.detect do |existing_snapshot|
                  existing_snapshot.time == snapshot['time']
                end
                unless exists
                  snapshot['symbol'] = symbol
                  snapshot['volume_from'] = snapshot['volumefrom']
                  snapshot['volume_to'] = snapshot['volumeto']
                  new_snapshots << snapshot.without('volumefrom', 'volumeto')
                end
              end

              ::CcSnapshot.create(new_snapshots) if new_snapshots.present?
            end
          end
          sleep(10.seconds)
        end
      end

    end
  end
end
