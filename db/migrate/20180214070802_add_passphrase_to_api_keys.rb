class AddPassphraseToApiKeys < ActiveRecord::Migration[5.1]
  def change
    add_column :api_keys, :passphrase, :string, null: true
  end
end
