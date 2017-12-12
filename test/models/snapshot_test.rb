# == Schema Information
#
# Table name: snapshots
#
#  id                 :integer          not null, primary key
#  cmc_id             :string
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
#
# Indexes
#
#  index_snapshots_on_cmc_id_and_cmc_last_updated  (cmc_id,cmc_last_updated) UNIQUE
#

require 'test_helper'

class SnapshotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
