# ::Generators::Providers::CryptoCompare
module Generators
  module Providers
    class CryptoCompare

      include HTTParty
      base_uri ENV['CRYPTO_COMPARE_URI']

      class << self

        def snapshots(symbol, params = {})
          response = request(
            '/histoday',
            params.merge(
              fsym: symbol,
              tsym: 'USD'
            )
          )
          if response['Response'] == 'Success'
            response['Data']
          else
            puts "SYMBOL FAILED: #{symbol}"
          end
        end

        private

        def request(uri, params = {})
          Rails.cache.fetch("#{base_uri}#{uri} #{params.to_json}", expires_in: 1.minutes) do
            get(
              uri,
              {
                query: params
              }
            ).parsed_response
          end
        end

        def delete_key(uri, params = {})
          Rails.cache.delete("#{base_uri}#{uri} #{params.to_json}")
        end

      end
    end
  end
end
