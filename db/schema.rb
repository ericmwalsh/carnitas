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

ActiveRecord::Schema.define(version: 20180215063332) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "provider", null: false
    t.string "key", null: false
    t.string "secret", null: false
    t.string "encryptor", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "passphrase"
    t.index ["user_id", "key"], name: "index_api_keys_on_user_id_and_key", unique: true
  end

  create_table "cc_snapshots", force: :cascade do |t|
    t.string "symbol"
    t.float "close"
    t.float "high"
    t.float "low"
    t.float "open"
    t.float "volume_from"
    t.float "volume_to"
    t.float "time"
    t.index ["symbol", "time"], name: "index_cc_snapshots_on_symbol_and_time", unique: true
  end

  create_table "crypto_portfolios", force: :cascade do |t|
    t.string "user_id"
    t.string "holdings", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "cmc_id"
    t.string "name"
    t.string "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inputs", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "symbol", null: false
    t.float "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "symbol"], name: "index_inputs_on_user_id_and_symbol", unique: true
  end

  create_table "snapshots", force: :cascade do |t|
    t.string "cmc_id"
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
    t.index ["cmc_id", "cmc_last_updated"], name: "index_snapshots_on_cmc_id_and_cmc_last_updated", unique: true
  end

end
