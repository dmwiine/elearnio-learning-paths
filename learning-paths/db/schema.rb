# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_09_08_100113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.string "bio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "author_id", null: false
    t.bigint "learning_path_id", null: false
    t.integer "order", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_courses_on_author_id"
    t.index ["learning_path_id"], name: "index_courses_on_learning_path_id"
  end

  create_table "learning_paths", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "talent_courses", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "talent_id", null: false
    t.boolean "completed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_talent_courses_on_course_id"
    t.index ["talent_id"], name: "index_talent_courses_on_talent_id"
  end

  create_table "talent_learning_paths", force: :cascade do |t|
    t.bigint "talent_id", null: false
    t.bigint "learning_path_id", null: false
    t.boolean "completed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["learning_path_id"], name: "index_talent_learning_paths_on_learning_path_id"
    t.index ["talent_id"], name: "index_talent_learning_paths_on_talent_id"
  end

  create_table "talents", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_id"], name: "index_talents_on_author_id"
  end

  add_foreign_key "courses", "authors"
  add_foreign_key "courses", "learning_paths"
  add_foreign_key "talent_courses", "courses"
  add_foreign_key "talent_courses", "talents"
  add_foreign_key "talent_learning_paths", "learning_paths"
  add_foreign_key "talent_learning_paths", "talents"
  add_foreign_key "talents", "authors"
end
