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

ActiveRecord::Schema.define(version: 2019_11_11_155159) do

  create_table "portfolios", force: :cascade do |t|
    t.integer "user_id"
  end

  create_table "positions", force: :cascade do |t|
    t.integer "portfolio_id"
    t.integer "stock_id"
    t.integer "quantity", default: 0, null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string "company_name"
    t.string "symbol"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.decimal "account_balance", precision: 10, scale: 2, default: "0.0", null: false
    t.string "email"
    t.string "password"
    t.string "security_answer"
  end

end
