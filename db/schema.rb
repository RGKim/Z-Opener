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

ActiveRecord::Schema.define(version: 20170718012929) do

  create_table "devices", force: :cascade do |t|
    t.string "domain"
    t.string "type"
    t.string "public_ip"
    t.string "private_ip"
    t.string "region"
    t.string "state"
    t.date "order_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "template_name"
    t.string "type"
    t.date "created_date"
    t.string "account"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "virtualmachines", force: :cascade do |t|
    t.string "datacenter"
    t.string "price"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
