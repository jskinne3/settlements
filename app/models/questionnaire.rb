class Questionnaire < ActiveRecord::Base
  require 'csv'

  attr_accessible :rndn, :area, :q1_4b, :q1_17c, :q1_17a, :q1_17b, :q1_19, :q2_1, :q2_2, :q2_3, :q2_4, :q2_6, :q2_7, :q3_1, :q3_2, :q3_6, :q3_9a, :q3_9b, :q3_9c, :q3_9d, :q3_9e, :q3_9f, :q3_10, :q4_1, :q4_2, :q4_3, :q4_5, :q4_6, :q4_7, :q4_9, :q4_19, :q4_20, :q4_21, :q5_1, :q6_1, :q6_2, :q6_3, :q6_4, :q6_5, :q6_6, :q7_1a, :q7_1b, :q7_1c, :q7_1d, :q7_1e, :q7_1f, :q7_1g, :q7_3, :q7_4, :q7_5, :q7_6, :q8_3, :q9_1, :q9_2, :inc_bw, :inc_all, :q9_3_bw, :q9_4_bw, :q9_9_bw, :q9_10_bw, :q9_11_bw, :q10_1, :q10_1a, :q10_2, :q10_3, :q10_4, :q10_5, :q10_6, :q10_7, :q10_8, :q10_9, :q10_10, :q1_12b, :under_15, :all_ages, :mos_in_home, :q2_2s, :q2_3s, :ltrs, :ltrsppn, :ltrsppc, :dds, :dds_cat, :q5_u5, :q5_adult, :morb_u5, :morb_adult, :morb_all, :q7_1all, :q7_1allc, :q7_2all, :inc_q5, :q10_allc, :hhs_cat, :hfias_cat
 
  before_create :handle_binary_questions

  def self.import(file)
    CSV.foreach(file.path, :headers => true) do |row|
      q_hash = row.to_hash
      q = Questionnaire.new
      q.attributes = q_hash.reject{|k,v| !q.attributes.keys.member?(k.to_s) }
      q.save(q_hash)
    end
  end

  def yn(input)
    if input.downcase == 'y'
      return true
    elsif input.downcase == 'n'
      return false
    else
      return nil
    end
  end

end
