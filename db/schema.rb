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

ActiveRecord::Schema.define(version: 20160321192529) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "availabilities", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "availabilities", ["user_id"], name: "index_availabilities_on_user_id", using: :btree

  create_table "class_rooms", force: :cascade do |t|
    t.integer  "lesson_id",       limit: 4
    t.integer  "teacher_id",      limit: 4
    t.integer  "student_id",      limit: 4
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "approve",                     default: false
    t.string   "sessionId",       limit: 255
    t.boolean  "public",                      default: false
    t.integer  "availability_id", limit: 4
    t.boolean  "with_credit",                 default: true
  end

  add_index "class_rooms", ["lesson_id"], name: "index_class_rooms_on_lesson_id", using: :btree

  create_table "credits", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.string   "status",           limit: 255, default: "purchased"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "ip",               limit: 255
    t.string   "express_token",    limit: 255
    t.string   "express_payer_id", limit: 255
    t.float    "price",            limit: 24
    t.string   "first_name",       limit: 255
    t.string   "last_name",        limit: 255
    t.string   "payer_email",      limit: 255
  end

  create_table "external_links", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "url",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "instruments", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "name",        limit: 255
    t.string   "level",       limit: 255
    t.text     "description", limit: 65535
    t.string   "duration",    limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "instrument",  limit: 255
  end

  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id", using: :btree

  create_table "levels", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body",          limit: 65535
    t.integer  "class_room_id", limit: 4
    t.integer  "user_id",       limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "messages", ["class_room_id"], name: "index_messages_on_class_room_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "body",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "author_id",  limit: 4
    t.integer  "rate",       limit: 4
  end

  add_index "reviews", ["author_id"], name: "index_reviews_on_author_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "site_settings", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "teacher_stuffs", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.string   "about",           limit: 255
    t.string   "music_experince", limit: 255
    t.string   "teach_experince", limit: 255
    t.string   "graduate",        limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "instrument",      limit: 255
  end

  add_index "teacher_stuffs", ["user_id"], name: "index_teacher_stuffs_on_user_id", using: :btree

  create_table "user_genres", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "genre_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_instruments", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "instrument_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_levels", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "level_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",        null: false
    t.string   "encrypted_password",     limit: 255,   default: "",        null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "user_type",              limit: 255,   default: "Student"
    t.boolean  "notifications"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "address",                limit: 255
    t.string   "city",                   limit: 255
    t.string   "phone",                  limit: 255
    t.text     "description",            limit: 65535
    t.string   "country",                limit: 255
    t.string   "zipcode",                limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.string   "region",                 limit: 255
    t.boolean  "active",                               default: true
    t.boolean  "verified",                             default: false
    t.datetime "last_seen"
    t.integer  "lesson_count",           limit: 4
    t.integer  "current_rating",         limit: 4
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "availabilities", "users"
end
