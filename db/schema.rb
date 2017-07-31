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

ActiveRecord::Schema.define(version: 20170731225537) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "eligibilities", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "eligibilities", ["name"], name: "index_eligibilities_on_name", using: :btree

  create_table "eligibilities_organizations", id: false, force: :cascade do |t|
    t.integer "eligibility_id"
    t.integer "organization_id"
  end

  add_index "eligibilities_organizations", ["eligibility_id"], name: "index_eligibilities_organizations_on_eligibility_id", using: :btree
  add_index "eligibilities_organizations", ["organization_id"], name: "index_eligibilities_organizations_on_organization_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.integer  "organization_id", null: false
    t.string   "name"
    t.string   "address",         null: false
    t.string   "city",            null: false
    t.string   "state",           null: false
    t.string   "zipcode",         null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "locations", ["organization_id"], name: "index_locations_on_organization_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
