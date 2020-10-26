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

ActiveRecord::Schema.define(version: 2020_10_26_095254) do

  create_table "comments", force: :cascade do |t|
    t.integer "meal_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "commenter"
    t.integer "comment_id"
    t.index ["comment_id"], name: "index_comments_on_comment_id"
    t.index ["commenter"], name: "index_comments_on_commenter"
    t.index ["meal_id"], name: "index_comments_on_meal_id"
  end

  create_table "meal_types", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content"
    t.integer "meal_type"
    t.integer "user_id"
    t.string "image"
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

end
