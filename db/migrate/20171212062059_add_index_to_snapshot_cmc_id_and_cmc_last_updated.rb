class AddIndexToSnapshotCmcIdAndCmcLastUpdated < ActiveRecord::Migration[5.1]
  def change
    add_index :snapshots, [:cmc_id, :cmc_last_updated], unique: true
  end
end
