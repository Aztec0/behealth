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

ActiveRecord::Schema[7.0].define(version: 2023_04_12_143808) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.date "birthday"
    t.string "position"
    t.string "email"
    t.bigint "phone"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "token_sent_at"
    t.integer "rating", default: 0
    t.integer "role", default: 0
    t.bigint "head_doctor_id"
    t.bigint "hospital_id"
    t.index ["head_doctor_id"], name: "index_doctors_on_head_doctor_id"
    t.index ["hospital_id"], name: "index_doctors_on_hospital_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.integer "rating"
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_feedbacks_on_doctor_id"
    t.index ["patient_id"], name: "index_feedbacks_on_patient_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "region"
    t.string "city"
    t.string "address"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "doctor_id"
    t.index ["doctor_id"], name: "index_hospitals_on_doctor_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.date "birthday"
    t.string "email"
    t.bigint "phone"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "token_sent_at"
    t.boolean "email_confirmed", default: false
    t.string "confirm_token"
  end

  add_foreign_key "doctors", "doctors", column: "head_doctor_id"
  add_foreign_key "doctors", "hospitals", on_delete: :nullify
  add_foreign_key "feedbacks", "doctors"
  add_foreign_key "feedbacks", "patients"
  add_foreign_key "hospitals", "doctors", on_delete: :nullify
end
