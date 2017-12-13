module PortfolioServices
  class CalculateDuration
    class << self

      def run(duration, portfolio_hash)
        cc_snapshots = ::CcSnapshot.where(
                          symbol: portfolio_hash.keys
                        ).where(
                          "time > ?", duration.days.ago.to_i
                        )

        duration_hash = {}

        portfolio_hash.each do |currency, quantity|
          currency_snapshots = cc_snapshots.select{|snapshot| snapshot.symbol == currency}
          currency_snapshots.each do |snapshot|
            if duration_hash[snapshot.time].present?
              duration_hash[snapshot.time] += quantity * snapshot.high
            else
              duration_hash[snapshot.time] = quantity * snapshot.high
            end
          end
        end

        {
          data: duration_hash.to_a
        }
      end

    end
  end
end
