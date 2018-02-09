class AddUniqueIndexToApiKeys < ActiveRecord::Migration[5.1]
  def change
    add_index :api_keys, [:user_id, :key], unique: true
  end
end
