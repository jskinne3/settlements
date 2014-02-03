class Questionnaire < ActiveRecord::Base
  require 'csv'
 
  def self.import(file)
    CSV.foreach(file.path, :headers => true) do |row|
      q_hash = row.to_hash
      Questionnaire.create!(q_hash)
    end 
  end

end
