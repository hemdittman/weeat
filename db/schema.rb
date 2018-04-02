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

ActiveRecord::Schema.define(version: 20180401145308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cuisines", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
    t.index ["name"], name: "index_cuisines_on_name", unique: true
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name", null: false
    t.integer "cuisine_id", null: false
    t.integer "rating"
    t.boolean "accepts_10bis", null: false
    t.string "address", null: false
    t.integer "max_delivery_time_minutes", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "longitude"
    t.float "latitude"
    t.index ["accepts_10bis"], name: "index_restaurants_on_accepts_10bis"
    t.index ["cuisine_id"], name: "index_restaurants_on_cuisine_id"
    t.index ["name", "address"], name: "index_restaurants_on_name_and_address", unique: true
    t.index ["name"], name: "index_restaurants_on_name"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "reviewer_name"
    t.integer "rating"
    t.text "comment"
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id", "rating"], name: "index_reviews_on_restaurant_id_and_rating"
    t.index ["restaurant_id"], name: "index_reviews_on_restaurant_id"
  end

  add_foreign_key "reviews", "restaurants"
end
