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

ActiveRecord::Schema.define(version: 20180905220903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "branches", force: :cascade do |t|
    t.string "title"
    t.string "location"
    t.integer "phone"
    t.bigint "manager_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_branches_on_manager_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
  end

  create_table "car_providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "card_payments", force: :cascade do |t|
    t.bigint "amount"
    t.bigint "sale_id"
    t.bigint "card_number"
    t.integer "card_type"
    t.integer "status"
    t.string "bank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_id"], name: "index_card_payments_on_sale_id"
  end

  create_table "cars", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.bigint "car_provider_id", null: false
    t.string "model", null: false
    t.string "license_plate", null: false
    t.integer "year"
    t.string "color", null: false
    t.float "milage"
    t.bigint "fuel_id"
    t.bigint "transmission_id"
    t.bigint "list_price"
    t.bigint "buy_price"
    t.integer "state", default: 0, null: false
    t.bigint "branch_id", null: false
    t.date "technical_review_expiration"
    t.string "book"
    t.string "cc"
    t.date "permit"
    t.integer "soap"
    t.string "property"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_cars_on_branch_id"
    t.index ["brand_id"], name: "index_cars_on_brand_id"
    t.index ["car_provider_id"], name: "index_cars_on_car_provider_id"
    t.index ["fuel_id"], name: "index_cars_on_fuel_id"
    t.index ["license_plate"], name: "index_cars_on_license_plate", unique: true
    t.index ["transmission_id"], name: "index_cars_on_transmission_id"
  end

  create_table "cash_payments", force: :cascade do |t|
    t.bigint "amount"
    t.bigint "sale_id"
    t.integer "deposit_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_id"], name: "index_cash_payments_on_sale_id"
  end

  create_table "check_payments", force: :cascade do |t|
    t.bigint "amount"
    t.bigint "sale_id"
    t.integer "status"
    t.bigint "code"
    t.integer "number"
    t.date "date"
    t.string "bank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_id"], name: "index_check_payments_on_sale_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "surname", null: false
    t.string "rut"
    t.string "address"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
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
    t.string "name", null: false
    t.string "surname", null: false
    t.string "rut", null: false
    t.string "address", null: false
    t.integer "phone", null: false
    t.string "avatar"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "employees_roles", id: false, force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "role_id"
    t.index ["employee_id", "role_id"], name: "index_employees_roles_on_employee_id_and_role_id"
    t.index ["employee_id"], name: "index_employees_roles_on_employee_id"
    t.index ["role_id"], name: "index_employees_roles_on_role_id"
  end

  create_table "financier_payments", force: :cascade do |t|
    t.bigint "amount"
    t.bigint "sale_id"
    t.integer "status"
    t.bigint "financier_id"
    t.bigint "down_payment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["financier_id"], name: "index_financier_payments_on_financier_id"
    t.index ["sale_id"], name: "index_financier_payments_on_sale_id"
  end

  create_table "financiers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fuels", force: :cascade do |t|
    t.string "name"
  end

  create_table "repairs", force: :cascade do |t|
    t.string "workshop"
    t.bigint "employee_id"
    t.bigint "car_id"
    t.text "reason"
    t.integer "quote"
    t.integer "status"
    t.date "return_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_repairs_on_car_id"
    t.index ["employee_id"], name: "index_repairs_on_employee_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "car_id"
    t.bigint "client_id"
    t.bigint "employee_id"
    t.bigint "branch_id"
    t.bigint "paid_amount"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_reservations_on_branch_id"
    t.index ["car_id"], name: "index_reservations_on_car_id"
    t.index ["client_id"], name: "index_reservations_on_client_id"
    t.index ["employee_id"], name: "index_reservations_on_employee_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "sales", force: :cascade do |t|
    t.bigint "branch_id"
    t.bigint "employee_id"
    t.bigint "car_id"
    t.bigint "client_id"
    t.bigint "final_price"
    t.bigint "appraisal"
    t.bigint "tax"
    t.bigint "transfer_cost"
    t.bigint "transfer_discount"
    t.bigint "list_discount"
    t.bigint "earnings"
    t.bigint "pva"
    t.bigint "list_price"
    t.bigint "buy_price"
    t.text "comment"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_id"], name: "index_sales_on_branch_id"
    t.index ["car_id"], name: "index_sales_on_car_id"
    t.index ["client_id"], name: "index_sales_on_client_id"
    t.index ["employee_id"], name: "index_sales_on_employee_id"
  end

  create_table "transfer_payments", force: :cascade do |t|
    t.bigint "amount"
    t.bigint "deposit"
    t.bigint "sale_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sale_id"], name: "index_transfer_payments_on_sale_id"
  end

  create_table "transmissions", force: :cascade do |t|
    t.string "name"
  end

  create_table "vehicle_payments", force: :cascade do |t|
    t.bigint "amount"
    t.bigint "sale_id"
    t.integer "status"
    t.bigint "car_id"
    t.boolean "mock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_vehicle_payments_on_car_id"
    t.index ["sale_id"], name: "index_vehicle_payments_on_sale_id"
  end

  add_foreign_key "branches", "employees", column: "manager_id"
  add_foreign_key "card_payments", "sales"
  add_foreign_key "cars", "branches"
  add_foreign_key "cars", "brands"
  add_foreign_key "cars", "car_providers"
  add_foreign_key "cars", "fuels"
  add_foreign_key "cars", "transmissions"
  add_foreign_key "cash_payments", "sales"
  add_foreign_key "check_payments", "sales"
  add_foreign_key "financier_payments", "financiers"
  add_foreign_key "financier_payments", "sales"
  add_foreign_key "repairs", "cars"
  add_foreign_key "repairs", "employees"
  add_foreign_key "reservations", "branches"
  add_foreign_key "reservations", "cars"
  add_foreign_key "reservations", "clients"
  add_foreign_key "reservations", "employees"
  add_foreign_key "sales", "branches"
  add_foreign_key "sales", "cars"
  add_foreign_key "sales", "clients"
  add_foreign_key "sales", "employees"
  add_foreign_key "transfer_payments", "sales"
  add_foreign_key "vehicle_payments", "cars"
  add_foreign_key "vehicle_payments", "sales"
end
