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

ActiveRecord::Schema.define(version: 20150118230023) do

  create_table "Articles", force: :cascade do |t|
    t.integer  "feed_id", limit: 4,        null: false
    t.string   "title",   limit: 256,      null: false
    t.string   "url",     limit: 512,      null: false
    t.string   "author",  limit: 64
    t.datetime "date"
    t.text     "content", limit: 16777215, null: false
  end

  add_index "Articles", ["feed_id"], name: "feed_id", using: :btree

  create_table "Feeds", force: :cascade do |t|
    t.string "name", limit: 64,       null: false
    t.binary "icon", limit: 16777215, null: false
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "feed_id",    limit: 4
    t.string   "title",      limit: 255
    t.string   "url",        limit: 255
    t.string   "author",     limit: 255
    t.datetime "date"
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "feeds", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.binary   "icon",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "likeds", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "article_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "feed_id",    limit: 4
    t.string   "folder",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "unreads", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "article_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "real_name",  limit: 255
    t.string   "email",      limit: 255
    t.string   "password",   limit: 255
    t.string   "cookie",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "Articles", "Feeds", column: "feed_id", name: "fk_Articles_feed_id"
end
