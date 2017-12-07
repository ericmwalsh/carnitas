class CreateSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :snapshots do |t|
      t.string :cmc_id
      t.integer :rank
      t.float :price_usd
      t.float :price_btc
      t.float :'24h_volume_usd'
      t.float :market_cap_usd
      t.float :available_supply
      t.float :total_supply
      t.float :max_supply
      t.float :percent_change_1h
      t.float :percent_change_24h
      t.float :percent_change_7d
      t.float :cmc_last_updated
    end
  end
end
