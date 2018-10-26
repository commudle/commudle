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

ActiveRecord::Schema.define(version: 2018_10_26_104157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["deleted_at"], name: "index_comments_on_deleted_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "communication_emails", force: :cascade do |t|
    t.text "subject"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_form_entities", force: :cascade do |t|
    t.bigint "data_form_id", null: false
    t.string "entity_type", null: false
    t.bigint "entity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_open", default: false
    t.string "slug"
    t.string "name"
    t.integer "visibility", default: 0
    t.index ["data_form_id"], name: "index_data_form_entities_on_data_form_id"
    t.index ["entity_type", "entity_id"], name: "index_data_form_entities_on_entity_type_and_entity_id"
  end

  create_table "data_form_entity_response_email_users", force: :cascade do |t|
    t.integer "data_form_entity_response_id"
    t.integer "registration_status_id"
    t.integer "event_status_id"
    t.integer "communication_email_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_form_entity_response_groups", force: :cascade do |t|
    t.integer "event_data_form_entity_group_id"
    t.integer "registration_status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.uuid "rsvp_token", default: -> { "uuid_generate_v4()" }
    t.index ["user_id"], name: "index_data_form_entity_response_groups_on_user_id"
  end

  create_table "data_form_entity_response_registration_status_logs", force: :cascade do |t|
    t.integer "data_form_entity_response_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "data_form_entity_response_values", force: :cascade do |t|
    t.integer "data_form_entity_response_id", null: false
    t.bigint "question_id", null: false
    t.text "text_response"
    t.bigint "question_choice_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_choice_id"], name: "index_data_form_entity_response_values_on_question_choice_id"
    t.index ["question_id"], name: "index_data_form_entity_response_values_on_question_id"
  end

  create_table "data_form_entity_responses", force: :cascade do |t|
    t.bigint "data_form_entity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "data_form_entity_response_group_id"
    t.index ["data_form_entity_id"], name: "index_data_form_entity_responses_on_data_form_entity_id"
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

  create_table "event_data_form_entity_groups", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "registration_type_id"
    t.bigint "user_id"
    t.string "slug"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_event_data_form_entity_groups_on_deleted_at"
    t.index ["event_id"], name: "index_event_data_form_entity_groups_on_event_id"
    t.index ["name", "event_id"], name: "index_event_data_form_entity_groups_on_name_and_event_id", unique: true
    t.index ["name"], name: "index_event_data_form_entity_groups_on_name"
    t.index ["registration_type_id"], name: "index_event_data_form_entity_groups_on_registration_type_id"
    t.index ["user_id"], name: "index_event_data_form_entity_groups_on_user_id"
  end

  create_table "event_entry_passes", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.string "unique_code", null: false
    t.bigint "created_by_id"
    t.boolean "attendance", default: false, null: false
    t.boolean "uninvited", default: false, null: false
    t.boolean "on_the_spot_registration", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_event_entry_passes_on_created_by_id"
    t.index ["event_id", "unique_code"], name: "index_event_entry_passes_on_event_id_and_unique_code", unique: true
    t.index ["event_id", "user_id"], name: "index_event_entry_passes_on_event_id_and_user_id", unique: true
    t.index ["event_id"], name: "index_event_entry_passes_on_event_id"
    t.index ["user_id"], name: "index_event_entry_passes_on_user_id"
  end

  create_table "event_location_tracks", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_location_id"
    t.index ["event_id"], name: "index_event_location_tracks_on_event_id"
    t.index ["event_location_id"], name: "index_event_location_tracks_on_event_location_id"
  end

  create_table "event_locations", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_locations_on_event_id"
    t.index ["location_id"], name: "index_event_locations_on_location_id"
  end

  create_table "event_status_logs", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "event_status_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_status_logs_on_event_id"
    t.index ["event_status_id"], name: "index_event_status_logs_on_event_status_id"
    t.index ["user_id"], name: "index_event_status_logs_on_user_id"
  end

  create_table "event_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_event_statuses_on_name"
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
    t.bigint "event_status_id"
    t.integer "seats", default: 0
    t.string "timezone"
    t.index ["end_time"], name: "index_events_on_end_time"
    t.index ["event_status_id"], name: "index_events_on_event_status_id"
    t.index ["kommunity_id"], name: "index_events_on_kommunity_id"
    t.index ["name"], name: "index_events_on_name"
    t.index ["start_time"], name: "index_events_on_start_time"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "fixed_email_dfe_response_groups", force: :cascade do |t|
    t.integer "data_form_entity_response_group_id", null: false
    t.bigint "fixed_email_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fixed_email_id"], name: "index_fixed_email_dfe_response_groups_on_fixed_email_id"
  end

  create_table "fixed_email_event_entry_passes", force: :cascade do |t|
    t.bigint "event_entry_pass_id"
    t.bigint "fixed_email_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_entry_pass_id"], name: "index_fixed_email_event_entry_passes_on_event_entry_pass_id"
    t.index ["fixed_email_id"], name: "index_fixed_email_event_entry_passes_on_fixed_email_id"
  end

  create_table "fixed_emails", force: :cascade do |t|
    t.string "mail_type"
    t.string "subject"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["name"], name: "index_kommunities_on_name", unique: true
    t.index ["slug"], name: "index_kommunities_on_slug", unique: true
    t.index ["user_id"], name: "index_kommunities_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.text "address", null: false
    t.text "map_link", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_choices", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.text "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_question_choices_on_deleted_at"
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
    t.boolean "required", default: false, null: false
    t.datetime "deleted_at"
    t.index ["data_form_id"], name: "index_questions_on_data_form_id"
    t.index ["deleted_at"], name: "index_questions_on_deleted_at"
    t.index ["question_type_id"], name: "index_questions_on_question_type_id"
  end

  create_table "registration_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_registration_statuses_on_name"
  end

  create_table "registration_type_statuses", force: :cascade do |t|
    t.bigint "registration_status_id"
    t.bigint "registration_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["registration_status_id"], name: "index_registration_type_statuses_on_registration_status_id"
    t.index ["registration_type_id"], name: "index_registration_type_statuses_on_registration_type_id"
  end

  create_table "registration_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_registration_types_on_name"
  end

  create_table "speaker_resources", force: :cascade do |t|
    t.bigint "data_form_entity_response_group_id"
    t.text "session_details_links"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["data_form_entity_response_group_id"], name: "index_speaker_resources_on_data_form_entity_response_group_id"
  end

  create_table "track_slots", force: :cascade do |t|
    t.bigint "event_location_track_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "session_title"
    t.bigint "speaker_registration_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_location_track_id"], name: "index_track_slots_on_event_location_track_id"
    t.index ["speaker_registration_id"], name: "index_track_slots_on_speaker_registration_id"
  end

  create_table "user_event_locations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "event_location_id", null: false
    t.integer "preference_order"
    t.boolean "is_selected", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_location_id"], name: "index_user_event_locations_on_event_location_id"
    t.index ["user_id"], name: "index_user_event_locations_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_user_roles_on_name", unique: true
  end

  create_table "user_roles_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "user_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "kommunity_id"
    t.index ["kommunity_id"], name: "index_user_roles_users_on_kommunity_id"
    t.index ["user_id", "user_role_id", "kommunity_id"], name: "index_user_role_kommunity", unique: true
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
    t.string "name"
    t.text "default_image"
    t.text "about_me"
    t.string "designation"
    t.text "personal_website"
    t.text "linkedin"
    t.text "github"
    t.text "twitter"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "comments", "users"
  add_foreign_key "data_form_entities", "data_forms"
  add_foreign_key "data_form_entity_response_email_users", "communication_emails", name: "index_dfereu_communication_status"
  add_foreign_key "data_form_entity_response_email_users", "data_form_entity_responses", name: "index_dfereu_response"
  add_foreign_key "data_form_entity_response_email_users", "event_statuses", name: "index_dfereu_event_status"
  add_foreign_key "data_form_entity_response_email_users", "registration_statuses", name: "index_dfereu_registration_status"
  add_foreign_key "data_form_entity_response_groups", "event_data_form_entity_groups", name: "index_user_repsponse_group_event_dfe_group"
  add_foreign_key "data_form_entity_response_groups", "registration_statuses", name: "index_user_repsponse_group_event_reg_status"
  add_foreign_key "data_form_entity_response_groups", "users"
  add_foreign_key "data_form_entity_response_registration_status_logs", "data_form_entity_responses", name: "index_data_form_entity_response_reg_status"
  add_foreign_key "data_form_entity_response_registration_status_logs", "users", name: "index_data_form_entity_response_reg_status_user"
  add_foreign_key "data_form_entity_response_values", "data_form_entity_responses", name: "index_dfe_response_values_on_dfe_response_id"
  add_foreign_key "data_form_entity_response_values", "question_choices"
  add_foreign_key "data_form_entity_response_values", "questions"
  add_foreign_key "data_form_entity_responses", "data_form_entities"
  add_foreign_key "data_form_entity_responses", "data_form_entity_response_groups", name: "index_user_repsponse_group_event_dfe_group"
  add_foreign_key "data_forms", "kommunities"
  add_foreign_key "data_forms", "users"
  add_foreign_key "event_data_form_entity_groups", "events"
  add_foreign_key "event_data_form_entity_groups", "registration_types"
  add_foreign_key "event_data_form_entity_groups", "users"
  add_foreign_key "event_entry_passes", "events"
  add_foreign_key "event_entry_passes", "users"
  add_foreign_key "event_entry_passes", "users", column: "created_by_id"
  add_foreign_key "event_location_tracks", "event_locations"
  add_foreign_key "event_location_tracks", "events"
  add_foreign_key "event_locations", "events"
  add_foreign_key "event_locations", "locations"
  add_foreign_key "event_status_logs", "event_statuses"
  add_foreign_key "event_status_logs", "events"
  add_foreign_key "event_status_logs", "users"
  add_foreign_key "events", "event_statuses"
  add_foreign_key "events", "kommunities"
  add_foreign_key "events", "users"
  add_foreign_key "fixed_email_dfe_response_groups", "data_form_entity_response_groups", name: "index_fixed_email_dfe_group"
  add_foreign_key "fixed_email_dfe_response_groups", "fixed_emails"
  add_foreign_key "fixed_email_event_entry_passes", "event_entry_passes"
  add_foreign_key "fixed_email_event_entry_passes", "fixed_emails"
  add_foreign_key "kommunities", "users"
  add_foreign_key "question_choices", "questions"
  add_foreign_key "questions", "data_forms"
  add_foreign_key "questions", "question_types"
  add_foreign_key "registration_type_statuses", "registration_statuses"
  add_foreign_key "registration_type_statuses", "registration_types"
  add_foreign_key "speaker_resources", "data_form_entity_response_groups"
  add_foreign_key "track_slots", "data_form_entity_response_groups", column: "speaker_registration_id"
  add_foreign_key "track_slots", "event_location_tracks"
  add_foreign_key "user_event_locations", "event_locations"
  add_foreign_key "user_event_locations", "users"
  add_foreign_key "user_roles_users", "kommunities"
end
