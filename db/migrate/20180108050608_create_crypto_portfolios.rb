class CreateCryptoPortfolios < ActiveRecord::Migration[5.1]
  def change
    create_table :crypto_portfolios do |t|
      t.string :user_id, unique: true
      t.string :holdings, null: false

      t.timestamps
    end
  end
end
