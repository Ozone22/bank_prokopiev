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

ActiveRecord::Schema.define(version: 20170206124250) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer  "account_type",    default: 0
    t.integer  "customer_id",                   null: false
    t.string   "account_number",                null: false
    t.float    "current_balance", default: 0.0
    t.datetime "closed_at"
    t.datetime "created_at"
    t.index ["customer_id"], name: "index_accounts_on_customer_id", using: :btree
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "sender_account_id",                  null: false
    t.integer  "recipient_account_id",               null: false
    t.float    "amount",               default: 0.0
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["recipient_account_id"], name: "index_transactions_on_recipient_account_id", using: :btree
    t.index ["sender_account_id"], name: "index_transactions_on_sender_account_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                           null: false
    t.string   "first_name",                      null: false
    t.string   "last_name",                       null: false
    t.string   "middle_name"
    t.string   "phone",                           null: false
    t.string   "password_digest",                 null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "two_step_auth",   default: false, null: false
    t.string   "google_secret"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["phone"], name: "index_users_on_phone", unique: true, using: :btree
  end

end
