module PortfolioServices
  class AggregateMonth
    class << self

      def run
        Rails.cache.fetch('::PortfolioServices::AggregateMonth.run', expires_in: 12.hours) do
          cc_snapshots = ::CcSnapshot.where('symbol IS NOT NULL').where("time > ?", 30.days.ago.to_i).order(:symbol, :time).group_by(&:symbol)

          {
            data: cc_snapshots
          }
        end
      end

    end
  end
end
