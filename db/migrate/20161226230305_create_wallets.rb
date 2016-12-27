class CreateWallets < ActiveRecord::Migration[5.0]
  def change
    create_table :wallets do |t|
      t.integer :money
      t.references :gamer, foreign_key: true

      t.timestamps
    end
  end
end
