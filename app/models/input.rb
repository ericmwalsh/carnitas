# == Schema Information
#
# Table name: inputs
#
#  id         :integer          not null, primary key
#  user_id    :string           not null
#  symbol     :string           not null
#  amount     :float            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_inputs_on_user_id_and_symbol  (user_id,symbol) UNIQUE
#

class Input < ApplicationRecord
  validates :user_id, presence: true
  validates :symbol, presence: true, inclusion: {
    in: Proc.new { self.get_currency_symbols },
    message: "%{value} is not a valid symbol"
  }
  validates :amount, presence: true

  validates_uniqueness_of :symbol, scope: :user_id

  after_commit :update_holdings

  def self.get_currency_symbols
    Rails.cache.fetch('symbols') do
      ::ExchangeWrapper::Temp::CoinMarketCap.refresh
    end
  end

  def update_holdings
    ::Portfolio::Inputs::UpdateHoldingsWorker.perform_async(user_id)
  end
end
