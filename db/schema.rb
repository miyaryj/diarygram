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

ActiveRecord::Schema.define(version: 20150810120644) do

  create_table "entries", force: :cascade do |t|
    t.string   "text"
    t.string   "date"
    t.integer  "user_id"
    t.string   "image_url"
    t.string   "thumbnail_url"
    t.string   "media_url"
    t.string   "instagram_media_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "instagram_users", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "instagram_user_id"
    t.string   "profile_image_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "instagram_users", ["user_id"], name: "index_instagram_users_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_followers", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "users_followers", ["followed_id"], name: "index_users_followers_on_followed_id"
  add_index "users_followers", ["follower_id", "followed_id"], name: "index_users_followers_on_follower_id_and_followed_id", unique: true
  add_index "users_followers", ["follower_id"], name: "index_users_followers_on_follower_id"

end
