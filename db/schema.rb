# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141107143216) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cause_states", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "causes", force: true do |t|
    t.string   "role"
    t.string   "matter"
    t.string   "honorary"
    t.datetime "date"
    t.integer  "client_id"
    t.integer  "area_id"
    t.integer  "court_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "causes", ["area_id"], name: "index_causes_on_area_id", using: :btree
  add_index "causes", ["client_id"], name: "index_causes_on_client_id", using: :btree
  add_index "causes", ["court_id"], name: "index_causes_on_court_id", using: :btree

  create_table "client_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "id_number"
    t.integer  "client_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["client_type_id"], name: "index_clients_on_client_type_id", using: :btree

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "phone"
    t.string   "email"
    t.integer  "person_id"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["client_id"], name: "index_companies_on_client_id", using: :btree
  add_index "companies", ["person_id"], name: "index_companies_on_person_id", using: :btree

  create_table "courts", force: true do |t|
    t.string   "name"
    t.integer  "region_id"
    t.integer  "area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courts", ["area_id"], name: "index_courts_on_area_id", using: :btree
  add_index "courts", ["region_id"], name: "index_courts_on_region_id", using: :btree

  create_table "journal_entries", force: true do |t|
    t.string   "subject"
    t.string   "body"
    t.datetime "date"
    t.integer  "cause_state_id"
    t.integer  "user_cause_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journal_entries", ["cause_state_id"], name: "index_journal_entries_on_cause_state_id", using: :btree
  add_index "journal_entries", ["user_cause_id"], name: "index_journal_entries_on_user_cause_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "id_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.text     "other"
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["client_id"], name: "index_people_on_client_id", using: :btree

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_causes", force: true do |t|
    t.integer  "user_id"
    t.integer  "cause_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_causes", ["cause_id"], name: "index_user_causes_on_cause_id", using: :btree
  add_index "user_causes", ["user_id"], name: "index_user_causes_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "id_number"
    t.string   "email",                  default: "", null: false
    t.string   "password"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["organization_id"], name: "index_users_on_organization_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end