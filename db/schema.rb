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

ActiveRecord::Schema.define(version: 6) do

  create_table "activities", force: true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.string   "agent"
    t.string   "controller"
    t.string   "identifier"
    t.string   "ip"
    t.string   "host"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["action"], name: "index_activities_on_action"
  add_index "activities", ["controller"], name: "index_activities_on_controller"
  add_index "activities", ["host"], name: "index_activities_on_host"
  add_index "activities", ["ip"], name: "index_activities_on_ip"
  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "content_pages", force: true do |t|
    t.string   "locale_name"
    t.string   "name"
    t.string   "state"
    t.text     "body"
    t.text     "description"
    t.text     "keywords"
    t.text     "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_pages", ["locale_name"], name: "index_content_pages_on_locale_name"
  add_index "content_pages", ["name"], name: "index_content_pages_on_name"
  add_index "content_pages", ["state"], name: "index_content_pages_on_state"

  create_table "content_uploads", force: true do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_uploads", ["name"], name: "index_content_uploads_on_name"

  create_table "content_widgets", force: true do |t|
    t.integer  "page_id"
    t.string   "locale_name"
    t.string   "name"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "content_widgets", ["locale_name"], name: "index_content_widgets_on_locale_name"
  add_index "content_widgets", ["name"], name: "index_content_widgets_on_name"
  add_index "content_widgets", ["page_id"], name: "index_content_widgets_on_page_id"

  create_table "locales", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locales", ["name"], name: "index_locales_on_name"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "state"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["state"], name: "index_users_on_state"

end
