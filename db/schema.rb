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

ActiveRecord::Schema.define(version: 2018_06_17_121153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "assignments", force: :cascade do |t|
    t.integer "student_id"
    t.integer "teacher_id"
    t.integer "code_lesson_id"
    t.datetime "date_due"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date_start"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.integer "chat_id"
    t.text "message"
    t.string "messageable_type"
    t.bigint "messageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["messageable_type", "messageable_id"], name: "index_chat_messages_on_messageable_type_and_messageable_id"
  end

  create_table "chats", force: :cascade do |t|
    t.integer "code_lesson_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "resolved", default: false
  end

  create_table "classes_courses", force: :cascade do |t|
    t.integer "organisation_class_id"
    t.integer "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "code_lesson_templates", force: :cascade do |t|
    t.string "name"
    t.text "instructions"
    t.text "hint"
    t.text "starting_code"
    t.integer "language_id"
    t.integer "order"
    t.integer "track_template_id"
    t.text "correctness_test"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "code_lessons", force: :cascade do |t|
    t.string "name"
    t.text "instructions"
    t.text "hint"
    t.text "starting_code"
    t.integer "language_id"
    t.integer "order"
    t.integer "track_id"
    t.text "correctness_test", default: ""
    t.datetime "date_due"
    t.datetime "date_start"
    t.boolean "visible", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "display_hint_after_attempts"
    t.integer "display_hint_after_minutes"
    t.integer "num_hints"
  end

  create_table "course_templates", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.integer "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "organisation_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "ace_slug"
    t.string "code_eval_slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "code_eval_version"
  end

  create_table "live_coding_sessions", force: :cascade do |t|
    t.integer "student_id"
    t.integer "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "code_lesson_id"
    t.boolean "resolved", default: false
    t.text "starting_code", default: ""
  end

  create_table "organisation_classes", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "organisation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "organisation_id"
    t.integer "points", default: 0
    t.index ["email"], name: "index_students_on_email", unique: true
    t.index ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true
  end

  create_table "students_classes", force: :cascade do |t|
    t.integer "student_id"
    t.integer "organisation_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students_lessons", force: :cascade do |t|
    t.integer "student_id"
    t.integer "code_lesson_id"
    t.integer "hint"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.integer "code_lesson_id"
    t.text "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "student_id"
    t.boolean "used_hint", default: false
    t.boolean "success", default: false
    t.integer "time_taken"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "organisation_id"
    t.index ["email"], name: "index_teachers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true
  end

  create_table "teachers_classes", force: :cascade do |t|
    t.integer "teacher_id"
    t.integer "organisation_class_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "track_templates", force: :cascade do |t|
    t.string "name"
    t.integer "order"
    t.integer "course_template_id"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "course_id"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
