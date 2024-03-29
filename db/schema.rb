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

ActiveRecord::Schema.define(version: 20140204123310) do

  create_table "bids", force: true do |t|
    t.decimal  "amount"
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bids", ["item_id"], name: "index_bids_on_item_id"
  add_index "bids", ["user_id"], name: "index_bids_on_user_id"

  create_table "categories", force: true do |t|
    t.string   "name",        limit: 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description", limit: 140
  end

  create_table "items", force: true do |t|
    t.string   "name",                limit: 50,                         null: false
    t.text     "description"
    t.decimal  "starting_price",                 precision: 9, scale: 2, null: false
    t.integer  "category_id",                                            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.datetime "close_date"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name",      limit: 50, null: false
    t.string   "last_name",       limit: 50, null: false
    t.string   "email",                      null: false
    t.string   "password_digest",            null: false
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
