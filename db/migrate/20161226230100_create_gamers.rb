class CreateGamers < ActiveRecord::Migration[5.0]
  def change
    create_table :gamers do |t|
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :born_date

      t.timestamps
    end
  end
end
