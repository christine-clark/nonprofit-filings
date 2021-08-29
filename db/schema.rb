# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_28_134754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: :cascade do |t|
    t.integer "grant_cash_amount"
    t.string "grant_purpose"
    t.bigint "receiver_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receiver_id"], name: "index_awards_on_receiver_id"
  end

  create_table "filers", force: :cascade do |t|
    t.integer "ein"
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "postal_code", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ein"], name: "index_filers_on_ein", unique: true
  end

  create_table "receivers", force: :cascade do |t|
    t.integer "ein"
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "postal_code", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ein"], name: "index_receivers_on_ein", unique: true
  end

end