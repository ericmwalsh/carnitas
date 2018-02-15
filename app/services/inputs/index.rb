# ::Inputs::Index
module Inputs
  class Index
    class << self

      def run(user_id)
        ::ActiveRecord::Base.connection.execute(query(user_id)).to_a
      end

      private

      def query(user_id)
        attributes = [:symbol, :amount]
        ::Input.
          where(user_id: user_id).
          select(attributes).to_sql
      end

    end
  end
end
