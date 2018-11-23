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

ActiveRecord::Schema.define(version: 20181123210211) do

  create_table "chat_room_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "chat_room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_chat_room_users_on_chat_room_id"
    t.index ["user_id"], name: "index_chat_room_users_on_user_id"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "favorited_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["favorited_user_id"], name: "index_favorites_on_favorited_user_id"
    t.index ["user_id", "favorited_user_id"], name: "index_favorites_on_user_id_and_favorited_user_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.integer "user_id"
    t.integer "chat_room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.datetime "read_at"
    t.string "action"
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "terms", force: :cascade do |t|
    t.text "body"
    t.boolean "agree"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_terms_on_user_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "years_sober"
    t.string "catchphrase"
    t.text "bio"
    t.datetime "last_seen"
    t.integer "role"
    t.index ["bio"], name: "index_users_on_bio"
    t.index ["catchphrase"], name: "index_users_on_catchphrase"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
    t.index ["username"], name: "index_users_on_username", unique: true
    t.index ["years_sober"], name: "index_users_on_years_sober"
  end

end
