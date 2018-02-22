# ::ApiIntegrations::Gdax::AccountApi
module ApiIntegrations
  module Gdax
    class AccountApi < ::ApiIntegrations::Gdax::Base

      class << self

        def accounts(key, secret, passphrase)
          request(key, secret, passphrase, :accounts)
        end

      end
    end
  end
end
