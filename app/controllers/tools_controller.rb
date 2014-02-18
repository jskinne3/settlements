class ToolsController < ApplicationController

  before_filter :authorize

  require 'rubygems'
  #require 'rinruby'

  BinaryQuestions = {
    'q3_6'  => 'Does your HH pay to use the toilet facility?',
    'q3_9a' => 'Yesterday did you wash your hands with soap after visiting toilet?',
    'q3_9b' => 'Yesterday did you wash your hands with soap before eating?',
    'q3_9c' => 'Yesterday did you wash your hands with soap before preparing food?',
    'q3_9d' => "Yesterday did you wash your hands with soap after handling child's waste?",
    'q3_9e' => 'Yesterday did you wash your hands with soap before feeding a child?',
    'q3_9f' => 'Yesterday did you wash your hands with soap after eating?',
    'q4_3'  => 'Did you consume a meal prepared outside the home yesterday (day & night)?',
    'q4_5'  => 'Did you eat cooked food purchased from the streets yesterday?',
    'q4_7'  => 'Did children in your household eat a meal served outside the home yesterday?',
    'q4_9'  => 'Did children eat cooked food purchased from the streets yesterday?',
    'q4_19' => 'In the past 4 weeks, did your household get relief food from any source?',
    'q4_20' => 'In the past 4 weeks, has your household been enrolled in any social safety net? (e.g. merry go round)',
    'q4_21' => 'In the past 4 weeks, did any child in the household benefit from a feeding program?',
    'q5_1'  => 'Has any member of your household (adult or child) been ill in the last 2 weeks?',
    'q7_1a' => 'Has your household or any member experienced fire in the last 4 weeks?',
    'q7_1b' => 'Has your household or any member experienced floods in the last 4 weeks?',
    'q7_1c' => 'Has your household or any member experienced mugging/stabbing in the last 4 weeks?',
    'q7_1d' => "Has your household or any member experienced buglary/'poof' in the last 4 weeks?",
    'q7_1e' => 'Has your household or any member experienced eviction in the last 4 weeks?',
    'q7_1f' => 'Has your household or any member experienced property destruction in the last 4 weeks?',
    'q7_1g' => 'Has your household or any member experienced rape/sodomy in the last 4 weeks?',
    'q10_1' => 'In the last 4 weeks have you purchased food or other essential household goods on credit because you didn’t have the money to buy them outright?',
    'q10_1a'=> 'Have you taken a loan to buy food or other essential HH goods in the last 4 weeks?',
    'q10_2' => 'Have you had to remove any of your children from school due to lack of school related costs in the last 4 weeks?',
    'q10_3' => 'Has any member of your household left/moved due to lack of resources to maintain them in the last 4 weeks?',
    'q10_4' => 'Have you or any member of your household gone out begging for food or money in the last 4 weeks?',
    'q10_5' => 'Have you or any household member traded sex for money or food in the last 4 weeks?',
    'q10_6' => 'Have you or any household member had multiple sexual partners in the last 4 weeks?',
    'q10_7' => 'Do you know someone in the community who had sex for money or food in the last month in the last 4 weeks?',
    'q10_8' => 'Have you or any household member stolen food or money to buy food in the last 4 weeks?',
    'q10_9' => 'Do you know someone in the community who stole food or money to buy food in the last one month?',
    'q10_10'=> 'Have you or any household member received food or money from friend/neighbor/relative in the last 4 weeks?'
  }
  TextQuestions = {
    'q2_1'  => 'What is the main source of drinking water members of your household have used in the last 2 weeks?',
    'q2_7'  => 'How would you rate the quality of water from your usual source in the last one week?',
    'q3_1'  => 'What kind of toilet facility has your household mainly/most commonly used during the day in the last 4 weeks?',
    'q3_2'  => 'What kind of toilet facility does your household mainly/most commonly used at night in the last 4 weeks',
    'q3_10' => 'Where has your household MAINLY disposed of garbage in the last 4 weeks?',
    'q4_1'  => 'In the last 4 weeks, what was the main source of food for your household?',
    'q6_1'  => 'How often have you had disputes with any person in the household in the last four weeks?',
    'q6_2'  => 'What was the severity of the dispute?',
    'q6_3'  => 'How often have you or another HH member had disputes with friends/neighbours outside your husehold in the last four weeks?',
    'q6_4'  => 'What was the severity of the dispute?',
    'q6_5'  => 'How often in the last 4 weeks have you shared food with your neighbours?',
    'q6_6'  => 'How often in the last 4 weeks has your neighbour shared food with you?',
    'q7_3'  => 'How often have you felt scared walking in the community in the last 4 weeks?',
    'q7_4'  => 'How often have you felt scared being in your house in the last 4 weeks?',
    'q7_5'  => 'How often have you/household member used avoidance measures in the last 4 weeks due to insecurity such as using escorts, using unusual routes, coming home earlier than usual etc?',
    'q7_6'  => 'How would you rate security situation in the community?',
    'q9_1'  => 'What is the main source of livelihood for your household in the past 4 weeks?'
  }
  NumberQuestions = {
    'inc_bw'      => 'Breadwinner income',
    'inc_all'     => 'All household income',
    'mos_in_home' => 'Months living in current home',
    'ltrs'        => 'Litres of water used per day by household',
    'ltrsppn'     => 'Liters of water used per person per day'
  }
  BackgroundQuestions = {
    'area' => 'Settlement area',
    'rndn' => 'Questionnaire round'
  }

  def rinruby_test
#    R.eval('age <- c(25, 30, 56)
#gender <- c("male", "female", "male")
#height <- c(160, 110, 220) 
#mydata <- data.frame(age,gender,height)
#png("~/concern/public/sample.png", 490, 350) 
#plot(mydata)
#dev.off()')
  end

  def index
    @q_count = Questionnaire.count
    @r_count = Questionnaire.count('rndn', :distinct => true)
    @a_count = Questionnaire.count('area', :distinct => true)
  end

  def bar
    # TODO: make a way to superimpose or otherwise compare two questions so that 
    # connections between them can be examined.
    all_questions = TextQuestions.merge(BinaryQuestions)
    @question_options = all_questions.keys.sort
    @bar_meaning_options = NumberQuestions.merge(BackgroundQuestions).keys
    @unit_options = ['number of answers', 'percent']
    @question = (params[:question].blank? ? 'q10_1a' : params[:question])
    @question_text = all_questions[@question.to_s]
    @bar_meaning = (params[:bar_meaning].blank? ? 'area' : params[:bar_meaning])
    @unit = (params[:unit].blank? ? 'percent' : params[:unit])
    @stack_bars = (params[:stack_bars] == 'unstacked' ? false : true)
    if (request.post? or params[:graphed] == '1') 
      @questionnaires = Questionnaire.where("#{@bar_meaning} IS NOT NULL")
      @color_meanings = @questionnaires.map{|q| q[@question.to_sym]}.uniq
      if ((@bar_meaning == 'area') or (@bar_meaning == 'rndn'))
        @bar_names = @questionnaires.map{|q|q[@bar_meaning.to_sym]}.uniq
      else
        #@bar_names = ['Q1', 'Q2', 'Q3', 'Q4']
        @questionnaires.sort!{|a,b| a[@bar_meaning.to_sym]<=>b[@bar_meaning.to_sym]}
        quintile_size = (@questionnaires.length / 5.0).to_i
        quintiles, @bar_names = Array.new, Array.new
        quintiles[0] = @questionnaires[0..quintile_size]
        quintiles[1] = @questionnaires[quintile_size..quintile_size*2]
        quintiles[2] = @questionnaires[quintile_size*2..quintile_size*3]
        quintiles[3] = @questionnaires[quintile_size*2..quintile_size*4]
        quintiles[4] = @questionnaires[quintile_size*4..-1]
        quintiles.each_with_index do |range, i|
          @bar_names << "#{range.first[@bar_meaning.to_sym]}–#{range.last[@bar_meaning.to_sym]}"
        end
      end
      # Container and header for chart data
      @data = [[@bar_meaning]+@color_meanings.map{|m| m.to_s}]
      @bar_names.each_with_index do |bar_name, i|
        if ((@bar_meaning == 'area') or (@bar_meaning == 'rndn'))
          # To create each bar in the chart, select all the questionnaires where area or rndn is a given name.
          qs_for_bar = @questionnaires.select{|q| q[@bar_meaning.to_sym] == bar_name}
        else
          # Or select the questionnaires where inc_all is in the correct quartile.
          qs_for_bar = quintiles[i]
        end
        row = Array.new
        for answer in @color_meanings
          # To create each region of a bar, count the questionnaires where the question is answered in a given way.
          row << qs_for_bar.select{|q| q[@question.to_sym] == answer}.count
        end
        if @unit == 'percent'
          sum = row.sum
          row = row.map{|n| ("%.2f" % ((n.to_f/sum.to_f)*100.0)).to_f}
        end
        row.unshift(bar_name) # Label each row
        @data << row
        # Replace color meaning db names with human-friendly names
        @data[0].map! do |heading|
          heading = 'no' if heading == 'false'
          heading = 'yes' if heading == 'true'
          heading = 'N/A' if heading == ''
          heading # Return final heading name from the block.
        end
      end
      # Calculate P-value with R
      #R.eval 'x <- read.csv("~/concern/public/john.csv")'
      #R.eval "y <- table(x$#{@bar_meaning}, x$#{@question})"
      #R.eval 'p <- chisq.test(y)$p.value'
      #@pvalue = R.pull 'p'
      @pvalue = 0.001
    end
  end

  def line
    @question_options = NumberQuestions.keys
    @question = (params[:question].blank? ? 'inc_all' : params[:question])
    @question_text = NumberQuestions[@question.to_s]
    @lim = (params[:lim] == '1')
    @std = (params[:std] == '1')
    if request.post?
      @questionnaires = Questionnaire.all
      @rounds = @questionnaires.map{|q|q.rndn}.uniq
      #@data = [['round', @question, 'top', 'bottom']]
      @data = Array.new
      for round in @rounds
        qs_in_round = @questionnaires.select{|q| q.rndn == round}
        datapoints = qs_in_round.map{|q| q[@question.to_sym] }.compact
        #render :text => datapoints.inspect
        #return
        sum = datapoints.sum
        n = datapoints.length.to_f
        mean = sum / n
        variance = datapoints.map{|i| (i-mean)**2 }.sum / n
        std_deviation = Math.sqrt(variance)
        data_row = [round, mean.round]
        if @lim
          data_row << datapoints.max
          data_row << datapoints.min
        end
        if @std
          data_row << (mean+(std_deviation/2.0)).round
          data_row << (mean-(std_deviation/2.0)).round
        end
        @data << data_row
      end
    else
      @lim, @std = false, true
    end
  end

=begin
  def line
    @questions = ['q3_6', 'q3_9a', 'q4_3', 'q7_1b', 'q10_1a']
    @questionnaires = Questionnaire.all
    @rounds = @questionnaires.map{|q|q.rndn}.uniq

    @data = [['round']+@questions]
    for round in @rounds
      percents_in_round = Array.new
      qs_in_round = @questionnaires.select{|q|q.rndn == round}
      for question in @questions
        answers = qs_in_round.map{|x| x[question.to_s]}
        trues = answers.select{|a| a == true}
        numerator = trues.count.to_f
        denominator = answers.count.to_f
        percents_in_round << ((numerator/denominator)*100).round
      end
      @data << [round]+percents_in_round
    end

  end
=end

end
