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

ActiveRecord::Schema.define(version: 2024_08_21_100558) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "base_app_documents", force: :cascade do |t|
    t.string "base_app_file_name"
    t.string "base_app_file_type"
    t.string "base_app_file_data"
    t.integer "base_app_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "base_app_features", force: :cascade do |t|
    t.string "name"
    t.integer "base_app_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "base_app_sub_features", force: :cascade do |t|
    t.string "name"
    t.integer "base_app_feature_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.boolean "selected"
  end

  create_table "base_apps", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.string "theme_color"
    t.string "app_platform"
    t.boolean "design"
    t.boolean "basic_build"
    t.boolean "full_build"
    t.text "note"
    t.string "budget"
    t.string "payment_way"
    t.boolean "support"
    t.boolean "cloud"
    t.boolean "market_place"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
  end

  create_table "basic_app_sub_features", force: :cascade do |t|
    t.string "name"
    t.integer "baseappfeature_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "otps", force: :cascade do |t|
    t.integer "user_id"
    t.string "otp_number"
    t.datetime "otp_expiry"
    t.string "type"
    t.string "email"
    t.string "mobile_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_app_documents", force: :cascade do |t|
    t.string "user_app_file_name"
    t.string "user_app_file_type"
    t.string "user_app_file_data"
    t.integer "user_app_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_app_features", force: :cascade do |t|
    t.string "name"
    t.integer "user_app_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_app_sub_features", force: :cascade do |t|
    t.string "name"
    t.integer "user_app_feature_id"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "selected"
  end

  create_table "user_apps", force: :cascade do |t|
    t.string "application_name"
    t.string "logo"
    t.string "theme_color"
    t.string "app_platform"
    t.boolean "design"
    t.boolean "basic_build"
    t.boolean "full_build"
    t.text "note"
    t.string "budget"
    t.string "payment_way"
    t.boolean "support"
    t.boolean "cloud"
    t.boolean "market_place"
    t.integer "user_id"
    t.string "status"
    t.string "step"
    t.string "coupon_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "user_type"
    t.integer "base_app"
    t.string "user_name"
    t.string "user_role"
    t.string "user_email"
    t.bigint "user_phone"
    t.string "description"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.bigint "phone_number"
    t.string "provider"
    t.string "uid"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "plaintext_password"
    t.string "profile"
    t.boolean "email_verified"
    t.boolean "mobile_verification"
    t.string "type"
    t.string "role"
    t.boolean "accepted_terms_conditions"
  end

end
