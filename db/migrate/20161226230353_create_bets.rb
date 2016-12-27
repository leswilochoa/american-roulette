class CreateBets < ActiveRecord::Migration[5.0]
  def change
    create_table :bets do |t|
      t.string :choice
      t.integer :amount
      t.integer :amount_won
      t.references :gamer, foreign_key: true
      t.references :round, foreign_key: true

      t.timestamps
    end
  end
end
