# ::ApiIntegrations::Exchanges::Base
module ApiIntegrations
  module Exchanges
    class Base < ::ApiIntegrations::Base
      # base_uri ENV['EXAMPLE_API_EXCHANGE_URI']

      class << self

        def holdings(params = {})
          raise ::NotImplementedError, 'implement this in your subclass'
        end

      end

    end
  end
end
