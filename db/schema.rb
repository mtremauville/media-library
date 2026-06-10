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

ActiveRecord::Schema[8.1].define(version: 2026_06_10_211024) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "episodes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "duration"
    t.integer "episode_number"
    t.bigint "media_item_id", null: false
    t.integer "season_number"
    t.text "synopsis"
    t.string "thumbnail_url"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["media_item_id"], name: "index_episodes_on_media_item_id"
  end

  create_table "media_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "external_id"
    t.string "media_type"
    t.jsonb "metadata"
    t.string "poster_url"
    t.decimal "rating"
    t.date "release_date"
    t.text "synopsis"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_media_items_on_user_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "duration"
    t.bigint "media_item_id", null: false
    t.string "title"
    t.integer "track_number"
    t.datetime "updated_at", null: false
    t.index ["media_item_id"], name: "index_tracks_on_media_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "full_name"
    t.string "provider"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "uid"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "episodes", "media_items"
  add_foreign_key "media_items", "users"
  add_foreign_key "tracks", "media_items"
end
