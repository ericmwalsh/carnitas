# ::ApiKeys::Index
module ApiKeys
  class Index
    class << self

      def run(user_id, decrypt = false)
        if decrypt
          decrypt_query = query(user_id, decrypt)
          ::ActiveRecord::Base.connection.execute(decrypt_query).map do |api_key|
            api_key.as_json.merge(
              secret: ::Utilities::Encryptor.decrypt(api_key['secret'])
            )
          end
        else
          ::ActiveRecord::Base.connection.execute(query(user_id)).to_a
        end
      end

      private

      def query(user_id, decrypt = false)
        attributes = if decrypt
          [:provider, :key, :secret, :encryptor]
        else
          [:provider, :key]
        end
        ::ApiKey.
          where(user_id: user_id).
          select(attributes).to_sql
      end

    end
  end
end
