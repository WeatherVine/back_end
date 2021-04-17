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

ActiveRecord::Schema.define(version: 2021_04_15_230016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_wines", force: :cascade do |t|
    t.bigint "wine_id"
    t.integer "user_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_wines_on_user_id"
    t.index ["wine_id"], name: "index_user_wines_on_wine_id"
  end

  create_table "wines", force: :cascade do |t|
    t.integer "api_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_id"], name: "index_wines_on_api_id", unique: true
  end

  add_foreign_key "user_wines", "wines"
end
