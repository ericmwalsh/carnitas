# ::ApiIntegrations::Coinbase::Base
module ApiIntegrations
  module Coinbase
    class Base

      class << self

        private

        def client(key, secret)
          ::Coinbase::Wallet::Client.new(
            api_key: key,
            api_secret: secret
          )
        end

      end
    end
  end
end
