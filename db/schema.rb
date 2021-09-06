# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_06_11_083709) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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

  create_table "articles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.text "content"
    t.integer "category_id"
    t.string "permalink", null: false
    t.integer "status", default: 0, null: false
    t.integer "coedit_permit", default: 0, null: false
    t.boolean "garbage", default: false, null: false
    t.datetime "published_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["content"], name: "index_articles_on_content"
    t.index ["permalink"], name: "index_articles_on_permalink", unique: true
    t.index ["title"], name: "index_articles_on_title"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "slug", limit: 30, null: false
    t.string "label", limit: 30, null: false
    t.string "ancestry"
    t.integer "edit_permit", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ancestry"], name: "index_categories_on_ancestry"
    t.index ["slug", "ancestry"], name: "index_categories_on_slug_and_ancestry", unique: true
  end

  create_table "category_assignments", force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_category_assignments_on_article_id"
    t.index ["category_id"], name: "index_category_assignments_on_category_id"
  end

  create_table "editable_category_group_assignments", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_editable_category_group_assignments_on_category_id"
    t.index ["group_id"], name: "index_editable_category_group_assignments_on_group_id"
  end

  create_table "editable_category_user_assignments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_editable_category_user_assignments_on_category_id"
    t.index ["user_id"], name: "index_editable_category_user_assignments_on_user_id"
  end

  create_table "editable_tag_group_assignments", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_editable_tag_group_assignments_on_group_id"
    t.index ["tag_id"], name: "index_editable_tag_group_assignments_on_tag_id"
  end

  create_table "editable_tag_user_assignments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_editable_tag_user_assignments_on_tag_id"
    t.index ["user_id"], name: "index_editable_tag_user_assignments_on_user_id"
  end

  create_table "group_user_assignments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_group_user_assignments_on_group_id"
    t.index ["user_id"], name: "index_group_user_assignments_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "slug", limit: 30, null: false
    t.string "name", limit: 30, null: false
    t.boolean "secret", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_groups_on_slug", unique: true
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "histories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "article_id", null: false
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_histories_on_article_id"
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_likes_on_article_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "readable_article_group_assignments", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_readable_article_group_assignments_on_article_id"
    t.index ["group_id"], name: "index_readable_article_group_assignments_on_group_id"
  end

  create_table "readable_article_user_assignments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_readable_article_user_assignments_on_article_id"
    t.index ["user_id"], name: "index_readable_article_user_assignments_on_user_id"
  end

  create_table "tag_assignments", force: :cascade do |t|
    t.integer "article_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_tag_assignments_on_article_id"
    t.index ["tag_id"], name: "index_tag_assignments_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "slug", limit: 30, null: false
    t.string "label", limit: 30, null: false
    t.integer "edit_permit", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["label"], name: "index_tags_on_label"
    t.index ["slug"], name: "index_tags_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name_id", limit: 30, null: false
    t.string "name", limit: 30, null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "introduction", limit: 200
    t.boolean "admin", default: false, null: false
    t.boolean "state", default: true, null: false
    t.boolean "indication", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name_id"], name: "index_users_on_name_id", unique: true
  end

  create_table "writable_article_group_assignments", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_writable_article_group_assignments_on_article_id"
    t.index ["group_id"], name: "index_writable_article_group_assignments_on_group_id"
  end

  create_table "writable_article_user_assignments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "article_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["article_id"], name: "index_writable_article_user_assignments_on_article_id"
    t.index ["user_id"], name: "index_writable_article_user_assignments_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "articles", "users"
  add_foreign_key "category_assignments", "articles"
  add_foreign_key "category_assignments", "categories"
  add_foreign_key "editable_category_group_assignments", "categories"
  add_foreign_key "editable_category_group_assignments", "groups"
  add_foreign_key "editable_category_user_assignments", "categories"
  add_foreign_key "editable_category_user_assignments", "users"
  add_foreign_key "editable_tag_group_assignments", "groups"
  add_foreign_key "editable_tag_group_assignments", "tags"
  add_foreign_key "editable_tag_user_assignments", "tags"
  add_foreign_key "editable_tag_user_assignments", "users"
  add_foreign_key "group_user_assignments", "groups"
  add_foreign_key "group_user_assignments", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "histories", "articles"
  add_foreign_key "histories", "users"
  add_foreign_key "readable_article_group_assignments", "articles"
  add_foreign_key "readable_article_group_assignments", "groups"
  add_foreign_key "readable_article_user_assignments", "articles"
  add_foreign_key "readable_article_user_assignments", "users"
  add_foreign_key "tag_assignments", "articles"
  add_foreign_key "tag_assignments", "tags"
  add_foreign_key "writable_article_group_assignments", "articles"
  add_foreign_key "writable_article_group_assignments", "groups"
  add_foreign_key "writable_article_user_assignments", "articles"
  add_foreign_key "writable_article_user_assignments", "users"
end
