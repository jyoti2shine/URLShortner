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

ActiveRecord::Schema.define(version: 20161009161230) do

  create_table "short_urls", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "original_url"
    t.string   "shorty"
    t.integer  "visits",       default: 0
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["user_id"], name: "index_short_urls_on_user_id", using: :btree
  end

  create_table "short_visits", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "short_url_id"
    t.string   "visitor_ip"
    t.string   "visitor_city"
    t.string   "visitor_state"
    t.string   "visitor_country"
    t.string   "visitor_zip"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["short_url_id"], name: "index_short_visits_on_short_url_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "api_token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "short_urls", "users"
  add_foreign_key "short_visits", "short_urls"
end
