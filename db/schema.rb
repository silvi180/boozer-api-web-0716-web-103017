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

ActiveRecord::Schema.define(version: 20180123034126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adjusted_proportions", force: :cascade do |t|
    t.string  "amount"
    t.integer "saved_drink_id"
    t.integer "ingredient_id"
    t.index ["ingredient_id"], name: "index_adjusted_proportions_on_ingredient_id", using: :btree
    t.index ["saved_drink_id"], name: "index_adjusted_proportions_on_saved_drink_id", using: :btree
  end

  create_table "cocktails", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "instructions"
    t.string "source"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
  end

  create_table "proportions", force: :cascade do |t|
    t.string  "amount"
    t.integer "cocktail_id"
    t.integer "ingredient_id"
    t.index ["cocktail_id"], name: "index_proportions_on_cocktail_id", using: :btree
    t.index ["ingredient_id"], name: "index_proportions_on_ingredient_id", using: :btree
  end

  create_table "saved_drinks", force: :cascade do |t|
    t.string  "name"
    t.string  "description"
    t.string  "instructions"
    t.string  "source"
    t.integer "cocktail_id"
    t.integer "user_id"
    t.index ["cocktail_id"], name: "index_saved_drinks_on_cocktail_id", using: :btree
    t.index ["user_id"], name: "index_saved_drinks_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string  "firstname"
    t.string  "lastname"
    t.string  "username"
    t.string  "email"
    t.string  "password_digest"
    t.integer "age"
    t.string  "bio"
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "adjusted_proportions", "ingredients"
  add_foreign_key "adjusted_proportions", "saved_drinks"
  add_foreign_key "proportions", "cocktails"
  add_foreign_key "proportions", "ingredients"
  add_foreign_key "saved_drinks", "cocktails"
  add_foreign_key "saved_drinks", "users"
end
