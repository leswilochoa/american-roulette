class Wallet < ApplicationRecord
  #structure
  #t.integer  "money"
  #t.integer  "gamer_id"
  #t.datetime "created_at", null: false
  #t.datetime "updated_at", null: false
  
  belongs_to :gamer
end
