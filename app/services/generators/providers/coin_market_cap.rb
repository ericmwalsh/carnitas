# ::Generators::Providers::CoinMarketCap
module Generators
  module Providers
    class CoinMarketCap

      include HTTParty
      base_uri ENV['COIN_MARKET_CAP_URI']

      class << self

        def currency(params = {})
          request('/ticker', params.merge(limit: 0))
        end

        alias_method :snapshot, :currency

        private

        def request(uri, params = {})
          Rails.cache.fetch("#{base_uri}#{uri} #{params.to_json}", expires_in: 9.minutes) do
            get(
              uri,
              {
                query: params
              }
            ).parsed_response
          end
        end

        def delete_key(uri, params = {})
          Rails.cache.delete("#{base_uri} #{uri} #{params.to_json}")
        end

      end
    end
  end
end
