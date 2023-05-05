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

ActiveRecord::Schema[7.0].define(version: 2023_05_05_095801) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.datetime "appointment_datetime"
    t.integer "status"
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.string "name"
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_calendars_on_doctor_id"
    t.index ["patient_id"], name: "index_calendars_on_patient_id"
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_chats_on_doctor_id"
    t.index ["patient_id"], name: "index_chats_on_patient_id"
  end

  create_table "conclusions", force: :cascade do |t|
    t.string "text"
    t.bigint "doctor_id"
    t.bigint "appointment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_conclusions_on_appointment_id"
    t.index ["doctor_id"], name: "index_conclusions_on_doctor_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.string "position"
    t.string "email"
    t.bigint "phone"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "token_sent_at"
    t.float "rating", default: 0.0
    t.integer "role", default: 0
    t.bigint "hospital_id"
    t.boolean "email_confirmed", default: true
    t.string "second_name"
    t.text "about"
    t.decimal "admission_price"
    t.string "second_email"
    t.bigint "second_phone"
    t.index ["hospital_id"], name: "index_doctors_on_hospital_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.integer "rating"
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "doctorable_id"
    t.string "doctorable_type"
    t.index ["doctorable_type", "doctorable_id"], name: "index_feedbacks_on_doctorable_type_and_doctorable_id"
    t.index ["patient_id"], name: "index_feedbacks_on_patient_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "region"
    t.string "city"
    t.string "address"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "rating", default: 0.0
  end

  create_table "id_cards", force: :cascade do |t|
    t.string "number"
    t.string "issued_by"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "chat_id", null: false
    t.bigint "patient_id", null: false
    t.bigint "doctor_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["doctor_id"], name: "index_messages_on_doctor_id"
    t.index ["patient_id"], name: "index_messages_on_patient_id"
  end

  create_table "passports", force: :cascade do |t|
    t.string "series"
    t.string "number"
    t.string "issued_by"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patient_addresses", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.string "settlement", null: false
    t.string "house", null: false
    t.string "apartments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address_type", null: false
    t.index ["patient_id"], name: "index_patient_addresses_on_patient_id"
  end

  create_table "patient_documents", force: :cascade do |t|
    t.bigint "patient_id", null: false
    t.string "document_type"
    t.bigint "document_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_type", "document_id"], name: "index_patient_documents_on_document"
    t.index ["patient_id"], name: "index_patient_documents_on_patient_id"
  end

  create_table "patient_works", force: :cascade do |t|
    t.string "work_type", null: false
    t.string "place", null: false
    t.string "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "patient_id", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
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
    t.bigint "chat_id"
    t.integer "sex", default: 0
    t.string "second_name"
    t.integer "tin"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag_name"
    t.string "tagable_type", null: false
    t.bigint "tagable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tagable_type", "tagable_id"], name: "index_tags_on_tagable"
  end

  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "patients"
  add_foreign_key "calendars", "doctors"
  add_foreign_key "calendars", "patients"
  add_foreign_key "chats", "doctors"
  add_foreign_key "chats", "patients"
  add_foreign_key "conclusions", "appointments"
  add_foreign_key "conclusions", "doctors"
  add_foreign_key "doctors", "hospitals", on_delete: :nullify
  add_foreign_key "feedbacks", "patients"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "doctors"
  add_foreign_key "messages", "patients"
  add_foreign_key "patient_addresses", "patients"
end
