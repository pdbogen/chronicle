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

ActiveRecord::Schema.define(version: 20140724032856) do

  create_table "characters", force: true do |t|
    t.string   "name",         limit: 128
    t.text     "levels"
    t.integer  "total_levels"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "play_sessions", force: true do |t|
    t.string   "name"
    t.boolean  "gm"
    t.integer  "user_id"
    t.integer  "scenario_id"
    t.datetime "played_at"
    t.integer  "tier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "play_sessions", ["scenario_id"], name: "index_play_sessions_on_scenario_id", using: :btree
  add_index "play_sessions", ["user_id"], name: "index_play_sessions_on_user_id", using: :btree

  create_table "rights", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "right_name", null: false
  end

  add_index "rights", ["right_name"], name: "index_rights_on_right_name", unique: true, using: :btree

  create_table "rights_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "right_id"
  end

  create_table "scenarios", force: true do |t|
    t.string   "name"
    t.boolean  "retired"
    t.integer  "season"
    t.integer  "episode"
    t.integer  "low_tier_lower"
    t.integer  "low_tier_upper"
    t.integer  "mid_tier_lower"
    t.integer  "mid_tier_upper"
    t.integer  "high_tier_lower"
    t.integer  "high_tier_upper"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scenarios", ["name"], name: "index_scenarios_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",                            null: false
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
