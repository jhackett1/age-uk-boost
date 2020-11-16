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

ActiveRecord::Schema.define(version: 2020_11_16_113216) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "orders", force: :cascade do |t|
    t.date "due"
    t.boolean "urgent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "approved"
    t.bigint "client_id"
    t.bigint "assignee_id"
    t.index ["assignee_id"], name: "index_orders_on_assignee_id"
    t.index ["client_id"], name: "index_orders_on_client_id"
  end

  create_table "orders_receipts", id: false, force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "receipt_id"
    t.index ["order_id"], name: "index_orders_receipts_on_order_id"
    t.index ["receipt_id"], name: "index_orders_receipts_on_receipt_id"
  end

  create_table "orders_services", id: false, force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "service_id"
    t.index ["order_id"], name: "index_orders_services_on_order_id"
    t.index ["service_id"], name: "index_orders_services_on_service_id"
  end

  create_table "receipts", force: :cascade do |t|
    t.bigint "user_id"
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "role_id"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "postcode"
    t.string "phone"
    t.float "latitude"
    t.float "longitude"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "receipts", "users"
  add_foreign_key "users", "roles"
end
