class AdminController < ApplicationController

  before_filter :authorize, :except => [:authorize, :login, :logout]

  def login
    if request.post?
      if params[:key].blank?
        flash[:notice] = 'No key entered.'
      else
        if params[:key] == 'ConcernWW'
          flash[:notice] = 'Key accepted for login.'
          session[:key] = 'hK78tsq$55.2y9'
          redirect_to :controller => 'tools', :action => 'bar'
        else
          flash[:notice] = 'Incorrect key.'
        end
      end
    end
  end

  def logout
    session[:key] = nil
    flash[:notice] = 'You have been logged out.'
    redirect_to :action => 'login'
  end

  def index
    @count = Questionnaire.count
  end

  def list
    @count = Questionnaire.count
    @questionnaires = Questionnaire.all
  end

  def import
    if request.post?
      unless params[:file]
        flash[:notice] = "No file selected."
        return
      else
        flash[:notice] = nil
      end
      @output = Array.new
      Questionnaire.import(params[:file])
    end
    @count = Questionnaire.count
  end

  def delete_all
    first_count = Questionnaire.count
    if request.post?
      for q in Questionnaire.all
        q.delete
      end
      @count = Questionnaire.count
      flash[:notice] = "Questionnaire table decreased by #{first_count - @count} rows."
    else
      @count = Questionnaire.count
      flash[:notice] = nil
    end
  end

=begin
  def old_import
    if request.post?
      @output = Array.new
      csv_file = params[:file].tempfile.to_s
      csv_text = File.read(params[:file].path)
      #csv = CSV.parse(csv_text, :headers => true)
      #csv.each do |row|
      csv_text.split("\n").each do |row|
        row = row.to_s.split(',')
        unless row[0] == 'rndn'
          q = Questionnaire.new
          q.rndn     = row[0]
          q.area     = row[1]
          q.q1_4b    = row[2]
          q.q1_17c   = row[3]
          q.q1_17a   = row[4]
          q.q1_17b   = row[5]
          q.q1_19    = row[6]
          q.q2_1     = row[7]
          q.q2_2     = row[8]
          q.q2_3     = row[9]
          q.q2_4     = row[10]
          q.q2_6     = row[11]
          q.q2_7     = row[12]
          q.q3_1     = row[13]
          q.q3_2     = row[14]
          q.q3_6     = yn(row[15])
          q.q3_9a    = yn(row[16])
          q.q3_9b    = yn(row[17])
          q.q3_9c    = yn(row[18])
          q.q3_9d    = yn(row[19])
          q.q3_9e    = yn(row[20])
          q.q3_9f    = yn(row[21])
          q.q3_10    = row[22]
          q.q4_1     = row[23]
          q.q4_2     = row[24]
          q.q4_3     = yn(row[25])
          q.q4_5     = yn(row[26])
          q.q4_6     = row[27]
          q.q4_7     = yn(row[28])
          q.q4_9     = yn(row[29])
          q.q4_19    = yn(row[30])
          q.q4_20    = yn(row[31])
          q.q4_21    = yn(row[32])
          q.q5_1     = yn(row[33])
          q.q6_1     = row[34]
          q.q6_2     = row[35]
          q.q6_3     = row[36]
          q.q6_4     = row[37]
          q.q6_5     = row[38]
          q.q6_6     = row[39]
          q.q7_1a    = yn(row[40])
          q.q7_1b    = yn(row[41])
          q.q7_1c    = yn(row[42])
          q.q7_1d    = yn(row[43])
          q.q7_1e    = yn(row[44])
          q.q7_1f    = yn(row[45])
          q.q7_1g    = yn(row[46])
          q.q7_3     = row[47]
          q.q7_4     = row[48]
          q.q7_5     = row[49]
          q.q7_6     = row[50]
          q.q8_3     = row[51]
          q.q9_1     = row[52]
          q.q9_2     = row[53]
          q.inc_bw   = row[54]
          q.inc_all  = row[55]
          q.q9_3_bw  = row[56]
          q.q9_4_bw  = row[57]
          q.q9_9_bw  = row[58]
          q.q9_10_bw = row[59]
          q.q9_11_bw = row[60]
          q.q10_1    = yn(row[61])
          q.q10_1a   = yn(row[62])
          q.q10_2    = yn(row[63])
          q.q10_3    = yn(row[64])
          q.q10_4    = yn(row[65])
          q.q10_5    = yn(row[66])
          q.q10_6    = yn(row[67])
          q.q10_7    = yn(row[68])
          q.q10_8    = yn(row[69])
          q.q10_9    = yn(row[70])
          q.q10_10   = yn(row[71])
          q.under_15 = row[73]
          q.all_ages = row[74]
          q.mos_in_home= row[75]
          q.ltrs     = row[78]
          q.ltrsppn  = row[79]
          q.save
        end
      end
    end
    @count = Questionnaire.count
  end

  private

  def yn(input)
    if input.downcase == 'y'
      return true
    elsif input.downcase == 'n'
      return false
    else
      return nil
    end
  end
  
=end

end
