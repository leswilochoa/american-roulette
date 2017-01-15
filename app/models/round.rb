class Round < ApplicationRecord
	#structure
	#t.string   "result"
    #t.datetime "created_at", null: false
    #t.datetime "updated_at", null: false

    has_many :bets
end
