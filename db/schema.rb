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

ActiveRecord::Schema.define(version: 20150216183238) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: true do |t|
    t.string   "long_name"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "honorary"
    t.datetime "start_date"
    t.datetime "first_payment_date"
    t.integer  "fee_quantity"
    t.integer  "client_id"
    t.integer  "area_id"
    t.integer  "court_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "periodicity"
    t.integer  "periodicity_measure"
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
    t.integer  "organization_client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["organization_client_id"], name: "index_companies_on_organization_client_id", using: :btree
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

  create_table "email_receiver_methods", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_receivers", force: true do |t|
    t.string   "address"
    t.integer  "port"
    t.string   "user_name"
    t.string   "password"
    t.boolean  "enable_starttls_auto"
    t.boolean  "enable_ssl"
    t.string   "authentication"
    t.string   "subject_filter"
    t.string   "remitter_filter"
    t.string   "body_filter"
    t.integer  "email_receiver_method_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "email_receivers", ["email_receiver_method_id"], name: "index_email_receivers_on_email_receiver_method_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "date_time"
    t.integer  "cause_id"
    t.integer  "user_id"
    t.boolean  "notified"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["cause_id"], name: "index_events_on_cause_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "invoices", force: true do |t|
    t.string   "description"
    t.integer  "amount"
    t.integer  "subscription_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "journal_entries", force: true do |t|
    t.string   "subject"
    t.text     "body"
    t.datetime "date"
    t.integer  "cause_state_id"
    t.integer  "user_cause_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "journal_entries", ["cause_state_id"], name: "index_journal_entries_on_cause_state_id", using: :btree
  add_index "journal_entries", ["user_cause_id"], name: "index_journal_entries_on_user_cause_id", using: :btree

  create_table "notification_types", force: true do |t|
    t.string   "name"
    t.string   "long_name"
    t.string   "color"
    t.string   "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.string   "subject"
    t.text     "description"
    t.string   "link"
    t.datetime "checked_at"
    t.boolean  "dismissable"
    t.datetime "dismissed_at"
    t.integer  "notification_type_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["notification_type_id"], name: "index_notifications_on_notification_type_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "organization_clients", force: true do |t|
    t.integer  "client_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organization_clients", ["client_id"], name: "index_organization_clients_on_client_id", using: :btree
  add_index "organization_clients", ["organization_id"], name: "index_organization_clients_on_organization_id", using: :btree

  create_table "organization_profiles", force: true do |t|
    t.integer  "organization_id"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organization_profiles", ["organization_id"], name: "index_organization_profiles_on_organization_id", using: :btree
  add_index "organization_profiles", ["profile_id"], name: "index_organization_profiles_on_profile_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "id_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_states", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.date     "date"
    t.boolean  "payed"
    t.integer  "amount"
    t.integer  "payment_number"
    t.integer  "cause_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "paid_amount"
  end

  add_index "payments", ["cause_id"], name: "index_payments_on_cause_id", using: :btree

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.text     "other"
    t.integer  "organization_client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["organization_client_id"], name: "index_people_on_organization_client_id", using: :btree

  create_table "permissions", force: true do |t|
    t.integer  "subject_id"
    t.integer  "action_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["action_id"], name: "index_permissions_on_action_id", using: :btree
  add_index "permissions", ["subject_id"], name: "index_permissions_on_subject_id", using: :btree

  create_table "plans", force: true do |t|
    t.string   "name"
    t.boolean  "causes"
    t.boolean  "payments"
    t.boolean  "clients"
    t.integer  "price_clp"
    t.integer  "price_usd"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profile_permissions", force: true do |t|
    t.integer  "permission_id"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profile_permissions", ["permission_id"], name: "index_profile_permissions_on_permission_id", using: :btree
  add_index "profile_permissions", ["profile_id"], name: "index_profile_permissions_on_profile_id", using: :btree

  create_table "profiles", force: true do |t|
    t.string   "long_name"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.string   "name"
    t.string   "long_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.string   "class_name"
    t.string   "scope"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "user_quantity"
    t.integer  "plan_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "paypal_customer_token"
    t.string   "paypal_recurring_profile_token"
  end

  add_index "subscriptions", ["organization_id"], name: "index_subscriptions_on_organization_id", using: :btree
  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree

  create_table "user_causes", force: true do |t|
    t.integer  "user_id"
    t.integer  "cause_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_causes", ["cause_id"], name: "index_user_causes_on_cause_id", using: :btree
  add_index "user_causes", ["user_id"], name: "index_user_causes_on_user_id", using: :btree

  create_table "user_settings", force: true do |t|
    t.integer  "user_id"
    t.integer  "setting_id"
    t.boolean  "enabled",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_settings", ["setting_id"], name: "index_user_settings_on_setting_id", using: :btree
  add_index "user_settings", ["user_id"], name: "index_user_settings_on_user_id", using: :btree

  create_table "user_types", force: true do |t|
    t.string   "name"
    t.string   "long_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "id_number"
    t.string   "email",                   default: "", null: false
    t.string   "password"
    t.integer  "organization_id"
    t.integer  "user_type_id"
    t.integer  "organization_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",      default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "email_receiver_enabled"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["organization_id"], name: "index_users_on_organization_id", using: :btree
  add_index "users", ["organization_profile_id"], name: "index_users_on_organization_profile_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["user_type_id"], name: "index_users_on_user_type_id", using: :btree

end
