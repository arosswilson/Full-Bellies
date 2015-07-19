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

ActiveRecord::Schema.define(version: 20150719222748) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deals", force: :cascade do |t|
    t.integer  "vendor_id"
    t.string   "title",                                 null: false
    t.string   "description",                           null: false
    t.integer  "item_quantity",                         null: false
    t.decimal  "item_price",    precision: 5, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.datetime "end_time"
  end

  create_table "favorite_vendors", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "vendor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchased_items", force: :cascade do |t|
    t.integer  "deal_id"
    t.integer  "user_id"
    t.integer  "quantity"
    t.decimal  "price",       precision: 5, scale: 2
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",               null: false
    t.string   "username",            null: false
    t.string   "password_digest",     null: false
    t.string   "phone_number"
    t.string   "profile_pic"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "vendors", force: :cascade do |t|
    t.string   "username",               null: false
    t.string   "password_digest",        null: false
    t.string   "email",                  null: false
    t.string   "name",                   null: false
    t.text     "bio"
    t.string   "address",                null: false
    t.string   "phone_number"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "access_token"
    t.boolean  "livemode"
    t.string   "refresh_token"
    t.string   "token_type"
    t.string   "stripe_publishable_key"
    t.string   "stripe_user_id"
    t.string   "scope"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
