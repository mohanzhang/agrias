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

ActiveRecord::Schema.define(:version => 20110425001939) do

  create_table "appointments", :force => true do |t|
    t.integer  "user_id"
    t.string   "description"
    t.text     "notes"
    t.datetime "occurs_at"
    t.boolean  "optional",    :default => false
    t.boolean  "attended",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aspects", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "weight"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aspects", ["ancestry"], :name => "index_aspects_on_ancestry"

  create_table "buffer_items", :force => true do |t|
    t.integer  "user_id"
    t.string   "phrase"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", :force => true do |t|
    t.integer  "user_id"
    t.string   "statement"
    t.date     "accomplish_on"
    t.boolean  "accomplished",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ideas", :force => true do |t|
    t.integer  "user_id"
    t.string   "synopsis"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "muses", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subtasks", :force => true do |t|
    t.integer  "task_id"
    t.string   "description"
    t.boolean  "accomplished", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.integer  "aspect_id"
    t.string   "description"
    t.text     "notes"
    t.date     "due_on"
    t.integer  "importance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state",       :default => 0, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
