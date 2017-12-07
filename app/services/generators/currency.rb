# ::Generators::Currency
module Generators
  class Currency < ::Generators::Base
    class << self

      private

      def cache(currency_hash)
        if currency = ::Currency.find_by_cmc_id(currency_hash['cmc_id'])
          currency.update(currency_hash)
        else
          ::Currency.create(currency_hash)
        end
      end

      def objects
        ::Generators::Providers::CoinMarketCap.currency.map do |currency|
          currency.merge(
            'cmc_id' => currency['id'],
            'cmc_last_updated' => currency['last_updated']
          ).without('id', 'last_updated')
        end
      end

    end
  end
end
