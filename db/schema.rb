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

ActiveRecord::Schema.define(version: 20140320234150) do

  create_table "events", force: true do |t|
    t.integer  "member_id"
    t.string   "title"
    t.string   "location"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.integer  "member_id"
    t.boolean  "hidden"
    t.string   "title"
    t.string   "company"
    t.string   "job_type"
    t.string   "location"
    t.date     "start_date"
    t.date     "deadline"
    t.string   "industry"
    t.text     "description"
    t.text     "qualification"
    t.text     "compensation"
    t.text     "how_to_apply"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.string   "member_type"
    t.string   "status"
    t.string   "password_digest"
    t.string   "image"
    t.string   "headline"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_name"
    t.integer  "class_year"
    t.string   "major"
    t.text     "summary"
    t.string   "url_resume"
    t.string   "location"
    t.string   "address"
    t.string   "industry"
    t.string   "email"
    t.string   "phone"
    t.string   "url_facebook"
    t.string   "url_twitter"
    t.string   "url_linkedIn"
    t.string   "url_personal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", force: true do |t|
    t.integer  "member_id"
    t.string   "title"
    t.string   "images"
    t.text     "summary"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
