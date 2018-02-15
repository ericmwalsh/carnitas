class CreateInputs < ActiveRecord::Migration[5.1]
  def change
    create_table :inputs do |t|
      t.string :user_id, null: false
      t.string :symbol, null: false
      t.float :amount, null: false

      t.timestamps
    end

    add_index :inputs, [:user_id, :symbol], unique: true
  end
end
