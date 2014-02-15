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

ActiveRecord::Schema.define(:version => 20140130120057) do

  create_table "questionnaires", :force => true do |t|
    t.string  "rndn"
    t.string  "area"
    t.integer "q1_4b"
    t.integer "q1_17c"
    t.integer "q1_17a"
    t.integer "q1_17b"
    t.integer "q1_19"
    t.string  "q2_1"
    t.integer "q2_2"
    t.integer "q2_3"
    t.integer "q2_4"
    t.integer "q2_6"
    t.string  "q2_7"
    t.string  "q3_1"
    t.string  "q3_2"
    t.boolean "q3_6"
    t.boolean "q3_9a"
    t.boolean "q3_9b"
    t.boolean "q3_9c"
    t.boolean "q3_9d"
    t.boolean "q3_9e"
    t.boolean "q3_9f"
    t.string  "q3_10"
    t.string  "q4_1"
    t.integer "q4_2"
    t.boolean "q4_3"
    t.boolean "q4_5"
    t.integer "q4_6"
    t.boolean "q4_7"
    t.boolean "q4_9"
    t.boolean "q4_19"
    t.boolean "q4_20"
    t.boolean "q4_21"
    t.boolean "q5_1"
    t.string  "q6_1"
    t.string  "q6_2"
    t.string  "q6_3"
    t.string  "q6_4"
    t.string  "q6_5"
    t.string  "q6_6"
    t.boolean "q7_1a"
    t.boolean "q7_1b"
    t.boolean "q7_1c"
    t.boolean "q7_1d"
    t.boolean "q7_1e"
    t.boolean "q7_1f"
    t.boolean "q7_1g"
    t.string  "q7_3"
    t.string  "q7_4"
    t.string  "q7_5"
    t.string  "q7_6"
    t.integer "q8_3"
    t.string  "q9_1"
    t.integer "q9_2"
    t.integer "inc_bw"
    t.integer "inc_all"
    t.integer "q9_3_bw"
    t.integer "q9_4_bw"
    t.integer "q9_9_bw"
    t.integer "q9_10_bw"
    t.integer "q9_11_bw"
    t.boolean "q10_1"
    t.boolean "q10_1a"
    t.boolean "q10_2"
    t.boolean "q10_3"
    t.boolean "q10_4"
    t.boolean "q10_5"
    t.boolean "q10_6"
    t.boolean "q10_7"
    t.boolean "q10_8"
    t.boolean "q10_9"
    t.boolean "q10_10"
    t.integer "under_15"
    t.integer "all_ages"
    t.integer "mos_in_home"
    t.integer "ltrs"
    t.float   "ltrsppn"
  end

end
