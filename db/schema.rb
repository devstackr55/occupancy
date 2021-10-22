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

ActiveRecord::Schema.define(version: 2021_08_05_180417) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.string "contact_person", null: false
    t.string "contacts"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "address"
    t.string "email"
  end

  create_table "employee_projects", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "project_id"
    t.integer "weekly_occupancy"
    t.datetime "start_at"
    t.datetime "ended_on"
    t.integer "role"
    t.string "comments"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_employee_projects_on_employee_id"
    t.index ["project_id"], name: "index_employee_projects_on_project_id"
  end

  create_table "employee_skills", force: :cascade do |t|
    t.bigint "employee_id"
    t.bigint "skill_id"
    t.integer "experience"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_primary", default: true
    t.index ["employee_id"], name: "index_employee_skills_on_employee_id"
    t.index ["skill_id"], name: "index_employee_skills_on_skill_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name", null: false
    t.integer "designation"
    t.integer "experience"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "ctc_per_day", precision: 4, scale: 2
    t.date "last_working_day"
    t.integer "development_skill", default: 0
    t.integer "client_management_skill", default: 0
    t.integer "mentorship_skill", default: 0
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "project_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal "total_amount"
    t.text "payment_reference"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "sales_remark"
    t.decimal "paid_amount"
    t.integer "status", default: 0
    t.integer "total_hours"
    t.datetime "paid_at"
  end

  create_table "project_skills", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "skill_id"
    t.integer "quantity", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_project_skills_on_project_id"
    t.index ["skill_id"], name: "index_project_skills_on_skill_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.integer "category", default: 0, null: false
    t.bigint "client_id"
    t.datetime "start_at", null: false
    t.datetime "expected_end_date"
    t.string "profile_name"
    t.integer "payment_cycle", null: false
    t.float "working_hours_per_week", null: false
    t.decimal "hourly_charge", precision: 8, scale: 2
    t.decimal "decimal", precision: 8, scale: 2
    t.string "skills_required"
    t.integer "status"
    t.string "end_reason"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_projects_on_client_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "timesheets", force: :cascade do |t|
    t.integer "project_id"
    t.decimal "billing_hours", precision: 4, scale: 2
    t.decimal "working_hours", precision: 4, scale: 2
    t.date "on_date"
    t.text "comments"
    t.text "references"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "invoice_id"
    t.integer "task_type", null: false
    t.integer "employee_id", null: false
    t.boolean "invoice_raised", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username"
    t.string "role"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "employee_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "employee_projects", "employees"
  add_foreign_key "employee_projects", "projects"
  add_foreign_key "employee_skills", "employees"
  add_foreign_key "employee_skills", "skills"
  add_foreign_key "project_skills", "projects"
  add_foreign_key "project_skills", "skills"
  add_foreign_key "projects", "clients"
end
