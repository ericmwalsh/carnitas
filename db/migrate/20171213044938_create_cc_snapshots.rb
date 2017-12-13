class CreateCcSnapshots < ActiveRecord::Migration[5.1]
  def change
    create_table :cc_snapshots do |t|
      t.string :symbol
      t.float :close
      t.float :high
      t.float :low
      t.float :open
      t.float :volume_from
      t.float :volume_to
      t.float :time
    end
  end
end
