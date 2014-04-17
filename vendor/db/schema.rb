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

ActiveRecord::Schema.define(version: 20140416013703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"
  enable_extension "hstore"

  create_table "_trigger_last_id", id: false, force: true do |t|
    t.integer "trigger_log_id"
  end

  create_table "_trigger_log", force: true do |t|
    t.string   "table_name", limit: 40
    t.string   "_c5_source", limit: 40
    t.string   "action",     limit: 7
    t.datetime "created_at",               default: "now()"
    t.integer  "record_id"
    t.string   "values",     limit: 16384
    t.string   "state",      limit: 8
    t.integer  "sf_result"
    t.string   "sf_message", limit: 1024
  end

  add_index "_trigger_log", ["state", "id", "created_at"], name: "idx__trigger_log_comp_key", using: :btree
  add_index "_trigger_log", ["table_name", "state"], name: "idx__trigger_log_name_state", using: :btree

  create_table "account", force: true do |t|
    t.string   "billingpostalcode", limit: 20
    t.string   "sfid",              limit: 18
    t.string   "_c5_source",        limit: 18
    t.datetime "lastmodifieddate"
    t.string   "website"
    t.string   "billingstreet"
    t.string   "name"
    t.string   "tickersymbol",      limit: 20
    t.string   "billingcity",       limit: 40
    t.boolean  "isdeleted"
    t.string   "phone",             limit: 40
    t.string   "billingstate",      limit: 80
    t.string   "billingcountry",    limit: 80
  end

  add_index "account", ["sfid"], name: "account_idx_sfid", unique: true, using: :btree

  create_table "accounts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "c5_versions", id: false, force: true do |t|
    t.string  "org_id",  limit: 60
    t.string  "app",     limit: 20, null: false
    t.integer "version"
  end

  create_table "contact", force: true do |t|
    t.date     "birthdate"
    t.string   "accountid",        limit: 18
    t.string   "phone",            limit: 40
    t.datetime "lastmodifieddate"
    t.string   "firstname",        limit: 40
    t.string   "title",            limit: 128
    t.string   "name",             limit: 121
    t.string   "department",       limit: 80
    t.string   "lastname",         limit: 80
    t.string   "sfid",             limit: 18
    t.string   "email",            limit: 80
    t.boolean  "isdeleted"
    t.string   "_c5_source",       limit: 18
  end

  add_index "contact", ["sfid"], name: "contact_idx_sfid", unique: true, using: :btree

  create_table "contacts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
