class CreateCurrencies < ActiveRecord::Migration[5.1]
  def change
    create_table :currencies do |t|
      t.string :cmc_id
      t.string :name
      t.string :symbol
      t.timestamps
    end
  end
end
