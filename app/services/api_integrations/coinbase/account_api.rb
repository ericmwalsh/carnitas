# ::ApiIntegrations::Coinbase::AccountApi
module ApiIntegrations
  module Coinbase
    class AccountApi < ::ApiIntegrations::Coinbase::Base

      class << self

        def accounts(key, secret)
          request(key, secret, :accounts)
        end

      end
    end
  end
end
