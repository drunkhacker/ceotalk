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

ActiveRecord::Schema.define(version: 20140209104200) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.integer  "parent_id"
    t.string   "name",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   default: 0, null: false
  end

  create_table "comments", force: true do |t|
    t.text     "content",                      null: false
    t.integer  "user_id",                      null: false
    t.integer  "commentable_id",               null: false
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.string   "type"
    t.boolean  "picked"
    t.integer  "like_count",       default: 0, null: false
  end

  create_table "companies", force: true do |t|
    t.string   "name",                                null: false
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_category_id"
    t.boolean  "featured",            default: false
    t.string   "logo"
    t.string   "email"
    t.string   "address"
    t.string   "tagline"
    t.text     "introduction"
  end

  create_table "company_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expert_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "featured_experts", force: true do |t|
    t.integer  "professional_id", null: false
    t.string   "featured_photo",  null: false
    t.text     "excerpt",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "likes", id: false, force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "comment_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["user_id", "comment_id"], name: "index_likes_on_user_id_and_comment_id", unique: true, using: :btree

  create_table "open_questions", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "view_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "url",                             null: false
    t.integer  "professional_id",                 null: false
    t.integer  "view_count",      default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",                           null: false
    t.text     "excerpt"
    t.string   "thumb_url"
    t.integer  "category_id",                     null: false
    t.boolean  "featured",        default: false
    t.integer  "order",           default: 0
  end

  create_table "presentations", force: true do |t|
    t.string   "url",                     null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "problem_id",              null: false
    t.integer  "user_id"
    t.integer  "vote_count",  default: 0, null: false
  end

  create_table "problems", force: true do |t|
    t.string   "url",                         null: false
    t.text     "content",                     null: false
    t.integer  "professional_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",                       null: false
    t.integer  "phase",           default: 0, null: false
    t.datetime "phase1_deadline"
    t.datetime "phase2_deadline"
    t.string   "thumb_url"
  end

  create_table "talks", force: true do |t|
    t.string   "url",                             null: false
    t.text     "description"
    t.integer  "professional_id",                 null: false
    t.integer  "view_count",      default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumb_url",                       null: false
    t.string   "title"
    t.integer  "category_id",                     null: false
    t.boolean  "featured",        default: false
    t.integer  "order",           default: 0
    t.string   "type"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                                   null: false
    t.string   "type"
    t.integer  "company_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "profile_photo"
    t.string   "position"
    t.integer  "expert_category_id"
    t.string   "short_description"
    t.text     "description"
    t.string   "quote"
    t.boolean  "featured",               default: false
    t.string   "tagline"
    t.text     "introduction"
    t.string   "career"
    t.string   "contact"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", id: false, force: true do |t|
    t.integer  "user_id",         null: false
    t.integer  "presentation_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["user_id", "presentation_id"], name: "index_votes_on_user_id_and_presentation_id", unique: true, using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id_and_comment_id", unique: true, using: :btree

end
