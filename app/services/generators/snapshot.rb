# ::Generators::Snapshot
module Generators
  class Snapshot < ::Generators::Base
    class << self

      def run
        new_snapshots = []
        new_snapshots_hash = {}
        snapshots = ::Generators::Providers::CoinMarketCap.snapshot

        snapshots.each do |snapshot|
          symbol = snapshot['symbol']
          formatted_snapshot = format(snapshot)

          unless existing_snapshot = ::Snapshot.find_by_cmc_id_and_cmc_last_updated(
                                        formatted_snapshot['cmc_id'],
                                        formatted_snapshot['cmc_last_updated']
                                      )
            new_snapshots << formatted_snapshot
          end
          new_snapshots_hash[symbol] = formatted_snapshot
        end

        if new_snapshots.present?
          ::Snapshot.create(new_snapshots)
        end
        update_latest_snapshots(new_snapshots_hash)
      end

      private

      def update_latest_snapshots(snapshots_hash)
        Rails.cache.write('latest-snapshots', snapshots_hash, expires_in: 1.day)
      end

      def format(snapshot)
        snapshot.merge(
          {
            'cmc_id' => snapshot['id'],
            'cmc_last_updated' => snapshot['last_updated']
          }
        ).without('id', 'last_updated', 'name', 'symbol')
      end

    end
  end
end
