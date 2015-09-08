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

ActiveRecord::Schema.define(version: 20150906103104) do

  create_table "admin_users", force: :cascade do |t|
    t.string   "first_name",      limit: 30
    t.string   "last_name",       limit: 50
    t.string   "username",        limit: 30
    t.string   "email",           limit: 100
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "admin_users", ["username"], name: "index_admin_users_on_username", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "img_url",    limit: 255
    t.text     "desc",       limit: 65535
    t.integer  "priority",   limit: 4
    t.boolean  "visibles",   limit: 1
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name",       limit: 100
    t.string   "email",      limit: 100
    t.string   "message",    limit: 500
    t.boolean  "read",       limit: 1,   default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "page_edits", force: :cascade do |t|
    t.integer  "page_id",       limit: 4
    t.integer  "admin_user_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "page_edits", ["page_id", "admin_user_id"], name: "index_page_edits_on_page_id_and_admin_user_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.integer  "category_id", limit: 4
    t.string   "title",       limit: 255
    t.text     "content",     limit: 65535
    t.string   "image_url",   limit: 255
    t.boolean  "visible",     limit: 1
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "permalink",   limit: 255
    t.integer  "hit_count",   limit: 4
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "page_id",    limit: 4
    t.string   "name",       limit: 255
    t.integer  "position",   limit: 4
    t.text     "content",    limit: 65535
    t.boolean  "visible",    limit: 1
    t.string   "img_url",    limit: 255
    t.string   "img_desc",   limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

end
