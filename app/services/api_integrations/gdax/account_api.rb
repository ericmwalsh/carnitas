# ::ApiIntegrations::Gdax::AccountApi
module ApiIntegrations
  module Gdax
    class AccountApi < ::ApiIntegrations::Gdax::Base

      class << self

        def accounts(key, secret, passphrase)
          client(key, secret, passphrase).accounts do |resp|
            resp
          end
        end

      end
    end
  end
end
