# == Schema Information
#
# Table name: currencies
#
#  id                 :integer          not null, primary key
#  cmc_id             :string
#  name               :string
#  symbol             :string
#  rank               :integer
#  price_usd          :float
#  price_btc          :float
#  24h_volume_usd     :float
#  market_cap_usd     :float
#  available_supply   :float
#  total_supply       :float
#  max_supply         :float
#  percent_change_1h  :float
#  percent_change_24h :float
#  percent_change_7d  :float
#  cmc_last_updated   :float
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
