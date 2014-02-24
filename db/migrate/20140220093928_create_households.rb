class CreateHouseholds < ActiveRecord::Migration
  def change
    create_table :households do |t|
      t.integer :objectid
      # Geospacial
      t.float   :lat
      t.float   :long
      # Predictor (X) Variables
      t.string  :area
      t.string  :rnd
      t.string  :city
      t.string  :inc_all_q5
      t.string  :q1_4b
      t.string  :yrs_in_homec
      t.string  :edu_bw
      # Response (Y) Variables
      #t.boolean  :q1_4b
      t.integer :under_5
      t.integer :over_18
      t.integer :all_ages
      t.float   :yrs_in_home
      t.string  :q1_19
      t.string  :q2_1
      t.integer :q2_2
      t.integer :q2_3
      t.boolean :q2_2s
      t.boolean :q2_3s
      t.boolean :q2_4
      t.float   :ltrsppn
      t.boolean :ltrsppc
      t.string  :q2_7
      t.string  :q3_1
      t.string  :q3_2
      t.boolean :q3_6
      t.boolean :q3_9a
      t.boolean :q3_9b
      t.boolean :q3_9c
      t.boolean :q3_9d
      t.boolean :q3_9e
      t.boolean :q3_9f
      t.string  :q3_10
      t.string  :q4_1
      t.integer :q4_2
      t.boolean :q4_3
      t.boolean :q4_5
      t.integer :q4_6
      t.boolean :q4_7
      t.boolean :q4_9
      t.integer :dds
      t.string  :hfias_cat
      t.string  :hhs_cat
      t.boolean :q4_19
      t.boolean :q4_20
      t.boolean :q4_21
      t.integer :fe_4wk
      t.float   :fe_inc_no
      t.boolean :q5_1
      t.integer :q5_2
      t.float   :morb_u5
      t.float   :morb_all
      t.string  :q6_1
      t.string  :q6_3
      t.string  :q6_5
      t.string  :q6_6
      t.boolean :q7_1a
      t.boolean :q7_1b
      t.boolean :q7_1c
      t.boolean :q7_1d
      t.boolean :q7_1e
      t.boolean :q7_1f
      t.boolean :q7_1_allc
      t.integer :q7_1_all
      t.string  :q7_3
      t.string  :q7_4
      t.string  :q7_5
      t.string  :q7_6
      t.string  :q8_1
      t.string  :q9_1
      t.integer :q9_2
      t.integer :q9_3_bw
      t.string  :q9_4_bw
      t.string  :q9_7_bw
      t.integer :q9_9_bw
      t.integer :q9_10_bw
      t.integer :q9_11_bw
      t.integer :inc_bw_no
      t.integer :inc_all_no
      #t.string  :inc_all_q5
      t.float   :bw_all
      t.integer :nfe_4wk
      t.float   :nfe_inc_no
      t.boolean :q10_1
      t.boolean :q10_1a
      t.boolean :q10_2
      t.boolean :q10_3
      t.boolean :q10_4
      t.boolean :q10_5
      t.boolean :q10_8
      t.boolean :q10_10
      t.boolean :q10_allc
      t.float   :q10_all
      t.timestamps
    end
  end
end
