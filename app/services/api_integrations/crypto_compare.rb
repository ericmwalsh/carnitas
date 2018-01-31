# ::ApiIntegrations::CryptoCompare
module ApiIntegrations
  class CryptoCompare < ::ApiIntegrations::Base
    base_uri ENV['CRYPTO_COMPARE_URI']

    class << self

      def snapshots(symbol, params = {})
        response = request(
          '/histoday',
          params.merge(
            fsym: symbol,
            tsym: 'USD'
          ),
          1.minutes
        )
        if response['Response'] == 'Success'
          response['Data']
        else
          # select distinct symbol from currencies except select distinct symbol from cc_snapshots;
          puts "SYMBOL FAILED: #{symbol}"
        end
      end

    end
  end
end
