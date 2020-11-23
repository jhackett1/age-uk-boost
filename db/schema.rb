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

ActiveRecord::Schema.define(version: 2020_11_23_203123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auth_sessions", force: :cascade do |t|
    t.string "token_digest", null: false
    t.datetime "claimed_at"
    t.datetime "expires_at", null: false
    t.datetime "timeout_at", null: false
    t.bigint "user_id"
    t.text "user_agent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_auth_sessions_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.text "special_request"
    t.bigint "user_id"
    t.datetime "completed_at"
    t.string "address"
    t.string "postcode"
    t.float "latitude"
    t.float "longitude"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "urgent"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "postcode"
    t.string "phone"
    t.float "latitude"
    t.float "longitude"
    t.boolean "admin"
    t.boolean "notify_about_due_tasks", default: true
    t.boolean "notify_about_new_tasks", default: true
    t.datetime "onboarded_at"
  end

  add_foreign_key "auth_sessions", "users"
  add_foreign_key "tasks", "users"
end
