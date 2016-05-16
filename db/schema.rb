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

ActiveRecord::Schema.define(version: 20160516113820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string   "uid",        null: false
    t.integer  "choice_id",  null: false
    t.integer  "survey_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
  end

  add_index "answers", ["choice_id"], name: "index_answers_on_choice_id", using: :btree
  add_index "answers", ["survey_id"], name: "index_answers_on_survey_id", using: :btree

  create_table "choices", force: :cascade do |t|
    t.string  "body",                      null: false
    t.integer "survey_id",                 null: false
    t.integer "position",  default: 0,     null: false
    t.boolean "free_form", default: false, null: false
  end

  add_index "choices", ["free_form"], name: "index_choices_on_free_form", using: :btree
  add_index "choices", ["position"], name: "index_choices_on_position", using: :btree
  add_index "choices", ["survey_id"], name: "index_choices_on_survey_id", using: :btree

  create_table "surveys", force: :cascade do |t|
    t.string   "public_url",                      null: false
    t.string   "private_url",                     null: false
    t.string   "title",                           null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid",                             null: false
    t.boolean  "public",          default: false, null: false
    t.boolean  "allow_free_form", default: false, null: false
  end

  add_index "surveys", ["private_url"], name: "index_surveys_on_private_url", unique: true, using: :btree
  add_index "surveys", ["public_url"], name: "index_surveys_on_public_url", unique: true, using: :btree

  add_foreign_key "answers", "choices"
  add_foreign_key "answers", "surveys"
end
