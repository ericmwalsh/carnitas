# ::Generators::Currency
module Generators
  class Currency < ::Generators::Base
    class << self

      def run
        currencies = ::Generators::Providers::CoinMarketCap.currency
        existing_currencies = ::Currency.where(cmc_id: currencies.map{|curr| curr['id']})

        currencies.each do |currency|
          cache(currency, existing_currencies)
        end
      end

      private

      def cache(currency, existing_currencies)
        formatted_currency = format(currency)
        if existing_currency = existing_currencies.detect {|curr| curr['cmc_id'] == currency['id']}
          unless formatted_currency == existing_currency.as_json(except: [:id, :created_at, :updated_at])
            existing_currency.update(formatted_currency)
          end
        else
          ::Currency.create(formatted_currency)
        end
      end

      def format(currency)
        {
          'cmc_id' => currency['id'],
          'name' => currency['name'],
          'symbol' => currency['symbol']
        }
      end

    end
  end
end
