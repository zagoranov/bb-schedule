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

ActiveRecord::Schema.define(version: 20140911175654) do

  create_table "days", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "number"
  end

  create_table "dictitems", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_ru"
    t.string   "desc_ru"
    t.string   "url_ru"
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

  create_table "trainings", force: true do |t|
    t.float    "weight"
    t.text     "info"
    t.integer  "day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

end
