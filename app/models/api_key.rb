# == Schema Information
#
# Table name: api_keys
#
#  id         :integer          not null, primary key
#  user_id    :string           not null
#  provider   :string           not null
#  key        :string           not null
#  secret     :string           not null
#  encryptor  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_api_keys_on_user_id_and_key  (user_id,key) UNIQUE
#

class ApiKey < ApplicationRecord
  validates :user_id, presence: true
  validates :provider, presence: true, inclusion: {
    in: %w(binance bittrex kucoin coinbase gdax gemini),
    message: "%{value} is not a valid provider"
  }
  validates_uniqueness_of :key, scope: :user_id
  validates :key, presence: true
  validates :secret, presence: true
  validates :encryptor, presence: true, inclusion: {
    in: %W(00 01 02 10 11 12 20 21 22),
    message: "%{value} is not a valid encryptor"
  }

  def api_secret
    ::Utilities::Encryptor.decrypt(secret)
  end

end
