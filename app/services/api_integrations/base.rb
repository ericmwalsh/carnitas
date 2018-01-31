# ::ApiIntegrations::Base
module ApiIntegrations
  class Base

    include HTTParty
    # base_uri ENV['EXAMPLE_BASE_URI']

    class << self

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

      def request(uri, params = {}, expires_in = 1.hour)
        Rails.cache.fetch("#{base_uri}#{uri} #{params.to_json}", expires_in: expires_in) do
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
