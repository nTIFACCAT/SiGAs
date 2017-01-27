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

ActiveRecord::Schema.define(version: 20170127161544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "associate_bonds", force: :cascade do |t|
    t.integer  "associate_id", null: false
    t.string   "bond",         null: false
    t.integer  "dependent_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["associate_id"], name: "index_associate_bonds_on_associate_id", using: :btree
    t.index ["dependent_id"], name: "index_associate_bonds_on_dependent_id", using: :btree
  end

  create_table "associate_charges", force: :cascade do |t|
    t.string   "description",  null: false
    t.integer  "associate_id", null: false
    t.float    "value",        null: false
    t.date     "due_date",     null: false
    t.date     "pay_date"
    t.float    "additions"
    t.float    "discounts"
    t.string   "payment_form"
    t.string   "obs"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["associate_id"], name: "index_associate_charges_on_associate_id", using: :btree
  end

  create_table "associates", force: :cascade do |t|
    t.string   "registration",                      null: false
    t.string   "name",                              null: false
    t.string   "gender",                            null: false
    t.date     "birthdate",                         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "cpf",                               null: false
    t.string   "rg",                                null: false
    t.string   "address",                           null: false
    t.string   "district",                          null: false
    t.string   "city",                              null: false
    t.string   "cep",                               null: false
    t.string   "phone",                             null: false
    t.string   "optional_phone"
    t.string   "email"
    t.integer  "category_id",                       null: false
    t.date     "adminission_date",                  null: false
    t.boolean  "active",             default: true, null: false
    t.string   "obs"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["category_id"], name: "index_associates_on_category_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "description",           null: false
    t.float    "value_in_cash",         null: false
    t.float    "value_in_installments", null: false
    t.boolean  "allow_dependents",      null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "dashboards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "direction_roles", force: :cascade do |t|
    t.integer  "associate_id", null: false
    t.string   "role",         null: false
    t.string   "biennium",     null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["associate_id"], name: "index_direction_roles_on_associate_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "email",                             null: false
    t.string   "encrypted_password",                null: false
    t.boolean  "active",             default: true, null: false
    t.string   "phone"
    t.string   "role"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "last_sign_in_at"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

end
