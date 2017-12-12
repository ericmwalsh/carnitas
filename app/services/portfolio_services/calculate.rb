module PortfolioServices
  class Calculate
    class << self

      def run(portfolio_hash)
        estimate_hash = {}
        latest_snapshots = fetch_latest_snapshots
        portfolio_hash.each do |currency, quantity|
          if snapshot = latest_snapshots[currency]
            estimate_hash[currency] = {
              quantity: quantity,
              price: snapshot['price_usd'].to_f,
              usd_value: quantity * snapshot['price_usd'].to_f,
              btc_value: quantity * snapshot['price_btc'].to_f
            }
          else
            estimate_hash[currency] = {
              quantity: quantity,
              usd_value: 0,
              btc_value: 0
            }
          end
        end

        {
          total: estimate_hash.values.sum{|curr| curr[:usd_value]},
          data: estimate_hash.sort_by{|curr, val_hash| -1 * val_hash[:usd_value]}.to_h
        }
      end

      private

      def fetch_latest_snapshots
        Rails.cache.read('latest-snapshots') || {}
      end

    end
  end
end
