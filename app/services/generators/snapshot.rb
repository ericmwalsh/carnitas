# ::Generators::Snapshot
module Generators
  class Snapshot < ::Generators::Base
    class << self

      private

      def cache(snapshot)
        if existing_snapshot = ::Snapshot.find_by_cmc_id_and_cmc_last_updated(snapshot['cmc_id'], snapshot['cmc_last_updated'])
          existing_snapshot.update(snapshot)
        else
          ::Snapshot.create(snapshot)
        end
      end

      def objects
        ::Generators::Providers::CoinMarketCap.snapshot.map do |snapshot|
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
end
