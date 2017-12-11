module PortfolioServices
  class Calculate
    class << self
      #
      def run(portfolio_hash)
        estimate_hash = {}
        portfolio_hash.each do |currency, quantity|
          if snapshot = Currency.find_by_symbol(currency).try(:snapshots).try(:order, cmc_last_updated: :desc).try(:first)
            estimate_hash[currency] = {
              quantity: quantity,
              price: snapshot['price_usd'],
              usd_value: quantity * snapshot['price_usd'],
              btc_value: quantity * snapshot['price_btc']
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
    end
  end
end
