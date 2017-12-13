class AddIndexToCcSnapshotsSymbolAndTime < ActiveRecord::Migration[5.1]
  def change
    add_index :cc_snapshots, [:symbol, :time], unique: true
  end
end
