class DropQuestionnairesTable < ActiveRecord::Migration
  def up
  	drop_table :questionnaires
  end

  def down
  	create_table :questionnaires do |t|
      t.string  :rndn, :area
      t.integer :q1_4b, :q1_17c, :q1_17a, :q1_17b, :q1_19
      t.string  :q2_1
      t.integer :q2_2, :q2_3, :q2_4, :q2_6
      t.string  :q2_7, :q3_1, :q3_2
      t.boolean :q3_6, :q3_9a, :q3_9b, :q3_9c, :q3_9d, :q3_9e, :q3_9f
      t.string  :q3_10, :q4_1
      t.integer :q4_2
      t.boolean :q4_3, :q4_5
      t.integer :q4_6
      t.boolean :q4_7, :q4_9, :q4_19, :q4_20, :q4_21, :q5_1
      t.string  :q6_1, :q6_2, :q6_3, :q6_4, :q6_5, :q6_6
      t.boolean :q7_1a, :q7_1b, :q7_1c, :q7_1d, :q7_1e, :q7_1f, :q7_1g
      t.string  :q7_3, :q7_4, :q7_5, :q7_6
      t.integer :q8_3
      t.string  :q9_1
      t.integer :q9_2
      t.integer :inc_bw, :inc_all, :q9_3_bw, :q9_4_bw, :q9_9_bw, :q9_10_bw, :q9_11_bw
      t.boolean :q10_1, :q10_1a, :q10_2, :q10_3, :q10_4, :q10_5, :q10_6, :q10_7, :q10_8, :q10_9, :q10_10
      t.integer :under_15, :all_ages, :mos_in_home, :ltrs
      t.float   :ltrsppn
    end
  end
end
