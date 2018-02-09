# ::ApiKeys::Index
module ApiKeys
  class Index
    class << self

      def run(user_id)
        ::ActiveRecord::Base.connection.execute(query(user_id)).to_a
      end

      private

      def query(user_id)
        ::ApiKey.
          where(user_id: user_id).
          select(:provider, :key, :secret).to_sql
      end

    end
  end
end
