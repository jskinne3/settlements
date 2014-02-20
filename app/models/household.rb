class Household < ActiveRecord::Base
	require 'csv'

  attr_accessible :objectid, :lat, :long, :area, :rnd, :city, :inc_all_q5, :q1_4b, :yrs_in_homec, :edu_bw, :under_5, :over_18, :all_ages, :yrs_in_home, :q1_19, :q2_1, :q2_2, :q2_3, :q2_2s, :q2_3s, :q2_4, :ltrsppn, :ltrsppc, :q2_7, :q3_1, :q3_2, :q3_6, :q3_9a, :q3_9b, :q3_9c, :q3_9d, :q3_9e, :q3_9f, :q3_10, :q4_1, :q4_2, :q4_3, :q4_5, :q4_6, :q4_7, :q4_9, :dds, :hfias_cat, :hhs_cat, :q4_19, :q4_20, :q4_21, :fe_4wk, :fe_inc_no, :q5_1, :q5_2, :morb_u5, :morb_all, :Name, :q6_1, :q6_3, :q6_5, :q6_6, :q7_1a, :q7_1b, :q7_1c, :q7_1d, :q7_1e, :q7_1f, :q7_1_allc, :q7_1_all, :q7_3, :q7_4, :q7_5, :q7_6, :q8_1, :q9_1, :q9_2, :q9_3_bw, :q9_4_bw, :q9_7_bw, :q9_9_bw, :q9_10_bw, :q9_11_bw, :inc_bw_no, :inc_all_no, :bw_all, :nfe_4wk, :nfe_inc_no, :q10_1, :q10_1a, :q10_2, :q10_3, :q10_4, :q10_5, :q10_8, :q10_10, :q10_allc, :q10_all

  def self.import(file)
    CSV.foreach(file.path, :headers => true) do |row|
      q_hash = row.to_hash
      q_hash.each do |k, v| # Would have liked to do this in a before_create instead.
        if (v == 'y' or v == 'Y')
          q_hash[k] = true
        elsif (v == 'n' or v == 'N')
          q_hash[k] = false
        end
      end
      q = Household.new
      q.attributes = q_hash.reject{|k,v| !q.attributes.keys.member?(k.to_s) }
      q.save(q_hash)
    end
  end

  def self.x_field_names
    self.column_names[4..10]
  end

  def self.y_field_names
    self.column_names[10..93]
  end

end
