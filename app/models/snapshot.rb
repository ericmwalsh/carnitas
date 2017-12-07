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

class Snapshot < ApplicationRecord

  belongs_to :currency, foreign_key: :cmc_id, primary_key: :cmc_id

end
