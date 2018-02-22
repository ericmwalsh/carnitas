class AddIsValidToApiKeys < ActiveRecord::Migration[5.1]
  def change
    add_column :api_keys, :is_valid, :boolean, null: false, default: true
    add_index :api_keys, [:user_id, :is_valid]
  end
end
