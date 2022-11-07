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

ActiveRecord::Schema.define(version: 20151202195617) do

  create_table "days", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "number"
    t.boolean  "archived",   default: false
    t.boolean  "erased",     default: false
    t.integer  "kind",       default: 0
    t.boolean  "shared2all", default: false
  end

  create_table "dictitems", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_ru"
    t.text     "desc_ru"
    t.string   "url_ru"
    t.string   "img"
    t.string   "img_ru"
    t.integer  "kind",        default: 0
  end

  create_table "dictnutrs", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.float    "protein"
    t.float    "fat"
    t.float    "carbs"
    t.float    "calories"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", force: true do |t|
    t.string   "title"
    t.string   "reps"
    t.integer  "day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "maxweight"
    t.integer  "number"
    t.integer  "dictitem_id"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mealdishes", force: true do |t|
    t.integer  "user_id"
    t.integer  "dictnutr_id"
    t.string   "meal_n"
    t.date     "dt"
    t.integer  "number"
    t.float    "doze"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "measurements", force: true do |t|
    t.float    "height"
    t.float    "weight"
    t.float    "neck"
    t.float    "shoulders"
    t.float    "chest"
    t.float    "biceps"
    t.float    "forearm"
    t.float    "wrist"
    t.float    "waist"
    t.float    "thighs"
    t.float    "calves"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "notecomments", force: true do |t|
    t.integer  "user_id"
    t.integer  "note_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "shared2all", default: false
  end

  create_table "profilecomments", force: true do |t|
    t.integer  "user_id"
    t.integer  "commenter_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainings", force: true do |t|
    t.float    "weight"
    t.text     "info"
    t.integer  "day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archived",   default: false
    t.integer  "kind",       default: 0
  end

  create_table "trexercises", force: true do |t|
    t.string   "title"
    t.string   "reps"
    t.integer  "training_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "maxweight"
    t.integer  "number"
    t.integer  "dictitem_id"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.boolean  "admin"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.boolean  "notific",          default: true
    t.datetime "lastlogin"
  end

end
