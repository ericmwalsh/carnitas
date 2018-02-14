# ::ApiIntegrations::Gdax::Base
module ApiIntegrations
  module Gdax
    class Base

      class << self

        private

        def client(key, secret, passphrase)
          ::Coinbase::Exchange::Client.new(key, secret, passphrase)
        end

      end
    end
  end
end
