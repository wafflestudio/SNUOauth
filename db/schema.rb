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

ActiveRecord::Schema.define(version: 20130730112728) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "app_requests", force: true do |t|
    t.integer  "app_id",       default: 0,  null: false
    t.integer  "app_token_id", default: 0,  null: false
    t.string   "type",         default: "", null: false
    t.integer  "status",       default: 0,  null: false
    t.string   "message",      default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_tokens", force: true do |t|
    t.integer  "app_id",       default: 0,        null: false
    t.integer  "user_id",      default: 0,        null: false
    t.boolean  "authorized",   default: false,    null: false
    t.string   "access_token", default: "",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token_type",   default: "bearer", null: false
  end

  add_index "app_tokens", ["access_token"], name: "index_app_tokens_on_access_token", unique: true

  create_table "apps", force: true do |t|
    t.integer  "user_id",      default: 0,  null: false
    t.string   "name",         default: "", null: false
    t.string   "publisher",    default: "", null: false
    t.text     "description",  default: "", null: false
    t.string   "website",      default: "", null: false
    t.string   "app_key",      default: "", null: false
    t.string   "app_secret",   default: "", null: false
    t.string   "redirect_uri", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apps", ["app_key"], name: "index_apps_on_app_key", unique: true
  add_index "apps", ["app_secret"], name: "index_apps_on_app_secret", unique: true

  create_table "comments", force: true do |t|
    t.integer  "user_id",    default: 0,  null: false
    t.integer  "post_id",    default: 0,  null: false
    t.text     "content",    default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id",    default: 0,  null: false
    t.string   "title",      default: "", null: false
    t.text     "content",    default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider",               default: "", null: false
    t.string   "uid",                    default: "", null: false
    t.string   "token",                  default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["provider"], name: "index_users_on_provider"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true

end
