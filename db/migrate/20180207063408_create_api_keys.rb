class CreateApiKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :api_keys do |t|
      t.string :user_id, null: false
      t.string :provider, null: false
      t.string :key, null: false
      t.string :secret, null: false

      t.timestamps
    end
  end
end
