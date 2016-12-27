class Bet < ApplicationRecord
  #structure
  	#t.string   "choice"
    #t.integer  "amount"
    #t.integer  "amount_won"
    #t.integer  "gamer_id"
    #t.integer  "round_id"
    #t.datetime "created_at", null: false
    #t.datetime "updated_at", null: false

  belongs_to :gamer
  belongs_to :round
end
