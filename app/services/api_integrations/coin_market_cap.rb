# ::ApiIntegrations::CoinMarketCap
module ApiIntegrations
  class CoinMarketCap

    include HTTParty
    base_uri ENV['COIN_MARKET_CAP_URI']

    class << self

      def currency(params = {})
        request('/ticker', params.merge(limit: 0))
      end

      alias_method :snapshot, :currency
      alias_method :get_request, :currency

      def refresh(params = {})
        refresh_request('/ticker', params.merge(limit: 0))
      end

      private

      def refresh_request(uri, params = {})
        Rails.cache.write(
          "#{base_uri}#{uri} #{params.to_json}",
          get(
            uri,
            {
              query: params
            }
          ).parsed_response
        )
      end

      def request(uri, params = {})
        Rails.cache.fetch("#{base_uri}#{uri} #{params.to_json}") do
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
