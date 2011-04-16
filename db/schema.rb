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

ActiveRecord::Schema.define(:version => 20110416194625) do

  create_table "appointments", :force => true do |t|
    t.string   "description"
    t.text     "notes"
    t.datetime "occurs_at"
    t.boolean  "optional",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "aspects", :force => true do |t|
    t.string   "name"
    t.integer  "weight"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aspects", ["ancestry"], :name => "index_aspects_on_ancestry"

  create_table "buffer_items", :force => true do |t|
    t.string   "phrase"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", :force => true do |t|
    t.string   "statement"
    t.date     "accomplish_on"
    t.boolean  "accomplished",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ideas", :force => true do |t|
    t.string   "synopsis"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "muses", :force => true do |t|
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
    t.boolean  "accomplished"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
