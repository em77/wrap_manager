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

ActiveRecord::Schema.define(version: 20161020164005) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", id: :serial, force: :cascade do |t|
    t.datetime "start"
    t.integer "client_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_appointments_on_client_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "client_actions", id: :serial, force: :cascade do |t|
    t.integer "wrap_session"
    t.text "notes"
    t.string "user_name"
    t.integer "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "wrap_action"
  end

  create_table "clients", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "wrap_status"
    t.string "first_name"
    t.string "last_name"
    t.index ["user_id"], name: "index_clients_on_user_id"
  end

  create_table "monthly_stats", id: :serial, force: :cascade do |t|
    t.integer "total_wrap_sessions"
    t.integer "unique_clients_attended_wrap_sessions"
    t.integer "total_wraps_opened"
    t.integer "total_wraps_completed"
    t.integer "unique_clients_attended_non_wrap"
    t.integer "total_non_wrap"
    t.integer "year"
    t.integer "month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "role"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "appointments", "clients"
  add_foreign_key "appointments", "users"
  add_foreign_key "clients", "users"
end
