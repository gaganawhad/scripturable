# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121213050825) do

  create_table "resources", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scripture_references", :force => true do |t|
    t.integer  "scripturable_id"
    t.string   "scripturable_type"
    t.string   "start_at"
    t.string   "end_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "scripture_references", ["scripturable_id"], :name => "index_scripture_references_on_scripturable_id"
  add_index "scripture_references", ["scripturable_type"], :name => "index_scripture_references_on_scripturable_type"

end
