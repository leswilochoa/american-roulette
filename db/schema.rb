# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161226230353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bets", force: :cascade do |t|
    t.string   "choice"
    t.integer  "amount"
    t.integer  "amount_won"
    t.integer  "gamer_id"
    t.integer  "round_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gamer_id"], name: "index_bets_on_gamer_id", using: :btree
    t.index ["round_id"], name: "index_bets_on_round_id", using: :btree
  end

  create_table "gamers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.date     "born_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rounds", force: :cascade do |t|
    t.string   "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallets", force: :cascade do |t|
    t.integer  "money"
    t.integer  "gamer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gamer_id"], name: "index_wallets_on_gamer_id", using: :btree
  end

  add_foreign_key "bets", "gamers"
  add_foreign_key "bets", "rounds"
  add_foreign_key "wallets", "gamers"
end
