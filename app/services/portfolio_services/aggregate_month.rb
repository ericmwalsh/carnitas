module PortfolioServices
  class AggregateMonth
    class << self

      def run
        cc_snapshots = ::CcSnapshot
                        .where('symbol IS NOT NULL')
                        .where("time > ?", 30.days.ago.to_i)
                        .order(:symbol, :time)
                        .pluck(:symbol, :high, :time)
                        .group_by {|snapshot| snapshot[0]}
                        .transform_values {|snapshots| snapshots.map{|snapshot| [snapshot[1], snapshot[2]]}}

        {
          data: cc_snapshots
        }
      end

    end
  end
end
