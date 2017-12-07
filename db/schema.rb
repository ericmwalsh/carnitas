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

ActiveRecord::Schema.define(version: 20171206065447) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currencies", force: :cascade do |t|
    t.string "cmc_id"
    t.string "name"
    t.string "symbol"
    t.integer "rank"
    t.float "price_usd"
    t.float "price_btc"
    t.float "24h_volume_usd"
    t.float "market_cap_usd"
    t.float "available_supply"
    t.float "total_supply"
    t.float "max_supply"
    t.float "percent_change_1h"
    t.float "percent_change_24h"
    t.float "percent_change_7d"
    t.float "cmc_last_updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end