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

ActiveRecord::Schema.define(version: 20180624143152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_form_entities", force: :cascade do |t|
    t.bigint "data_form_id", null: false
    t.string "entity_type", null: false
    t.bigint "entity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_open", default: false
    t.string "slug"
    t.string "name"
    t.index ["data_form_id"], name: "index_data_form_entities_on_data_form_id"
    t.index ["entity_type", "entity_id"], name: "index_data_form_entities_on_entity_type_and_entity_id"
  end

  create_table "data_forms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "kommunity_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["kommunity_id"], name: "index_data_forms_on_kommunity_id"
    t.index ["user_id"], name: "index_data_forms_on_user_id"
  end

  create_table "event_users", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.boolean "shortlisted", default: false
    t.boolean "rsvp", default: false
    t.boolean "attended", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_users_on_event_id"
    t.index ["user_id"], name: "index_event_users_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "kommunity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "slug"
    t.index ["end_time"], name: "index_events_on_end_time"
    t.index ["kommunity_id"], name: "index_events_on_kommunity_id"
    t.index ["name"], name: "index_events_on_name"
    t.index ["start_time"], name: "index_events_on_start_time"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "form_responses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "data_form_entity_id", null: false
    t.string "parent_type", null: false
    t.bigint "parent_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_form_entity_id"], name: "index_form_responses_on_data_form_entity_id"
    t.index ["parent_type", "parent_id"], name: "index_form_responses_on_parent_type_and_parent_id"
    t.index ["user_id"], name: "index_form_responses_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "kommunities", force: :cascade do |t|
    t.string "name", null: false
    t.text "about"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["name"], name: "index_kommunities_on_name"
    t.index ["user_id"], name: "index_kommunities_on_user_id"
  end

  create_table "question_choices", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.text "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_choices_on_question_id"
  end

  create_table "question_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_question_types_on_name", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "question_type_id", null: false
    t.bigint "data_form_id", null: false
    t.text "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_form_id"], name: "index_questions_on_data_form_id"
    t.index ["question_type_id"], name: "index_questions_on_question_type_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_user_roles_on_name", unique: true
  end

  create_table "user_roles_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "user_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "user_role_id"], name: "index_user_roles_users_on_user_id_and_user_role_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "data_form_entities", "data_forms"
  add_foreign_key "data_forms", "kommunities"
  add_foreign_key "data_forms", "users"
  add_foreign_key "event_users", "events"
  add_foreign_key "event_users", "users"
  add_foreign_key "events", "kommunities"
  add_foreign_key "events", "users"
  add_foreign_key "form_responses", "data_form_entities"
  add_foreign_key "form_responses", "users"
  add_foreign_key "kommunities", "users"
  add_foreign_key "question_choices", "questions"
  add_foreign_key "questions", "data_forms"
  add_foreign_key "questions", "question_types"
end
