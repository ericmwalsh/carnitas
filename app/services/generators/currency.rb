# ::Generators::Currency
module Generators
  class Currency < ::Generators::Base
    class << self

      private

      def cache(currency)
        if existing_currency = ::Currency.find_by_cmc_id(currency['cmc_id'])
          existing_currency.update(currency)
        else
          ::Currency.create(currency)
        end
      end

      def objects
        ::Generators::Providers::CoinMarketCap.currency.map do |currency|
          {
            'cmc_id' => currency['id'],
            'name' => currency['name'],
            'symbol' => currency['symbol']
          }
        end
      end

    end
  end
end
