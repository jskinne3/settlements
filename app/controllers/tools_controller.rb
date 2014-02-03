class ToolsController < ApplicationController

  BinaryQuestions = ['q3_6', 'q3_9a', 'q3_9b', 'q3_9c', 'q3_9d', 'q3_9e', 'q3_9f', 'q4_3', 'q4_5', 'q4_7', 'q4_9', 'q4_19', 'q4_20', 'q4_21', 'q5_1', 'q7_1a', 'q7_1b', 'q7_1c', 'q7_1d', 'q7_1e', 'q7_1f', 'q7_1g', 'q10_1', 'q10_1a', 'q10_2', 'q10_3', 'q10_4', 'q10_5', 'q10_6', 'q10_7', 'q10_8', 'q10_9', 'q10_10']
  TextQuestions = ['q2_1', 'q2_7', 'q3_1', 'q3_2', 'q3_10', 'q4_1', 'q6_1', 'q6_2', 'q6_3', 'q6_4', 'q6_5', 'q6_6', 'q7_3', 'q7_4', 'q7_5', 'q7_6', 'q9_1']

  def index
    @q_count = Questionnaire.count
    @r_count = Questionnaire.count('rndn', :distinct => true)
    @a_count = Questionnaire.count('area', :distinct => true)
  end

  def bar
    @question_options = TextQuestions + BinaryQuestions
    @bar_meaning_options = ['area', 'rndn']
    @unit_options = ['number of answers', 'percent']
    @question = (params[:question].blank? ? 'q10_1a' : params[:question])
    @bar_meaning = (params[:bar_meaning].blank? ? 'area' : params[:bar_meaning])
    @unit = (params[:unit].blank? ? 'percent' : params[:unit])
    if request.post?
      @questionnaires = Questionnaire.all
      @color_meanings = @questionnaires.map{|q| q[@question.to_sym]}.uniq
      @bar_names = @questionnaires.map{|q|q[@bar_meaning.to_sym]}.uniq
      # Container and header for chart data
      @data = [[@bar_meaning]+@color_meanings.map{|m| m.to_s}]
      for bar_name in @bar_names
        # To create each bar in the chart, select all the questionnaires where area or rndn is a given name.
        qs_for_bar = @questionnaires.select{|q| q[@bar_meaning.to_sym] == bar_name}
        row = Array.new
        for answer in @color_meanings
          # To create each region of a bar, count the questionnaires where the question is answered in a given way.
          row << qs_for_bar.select{|q| q[@question.to_sym] == answer}.count
        end
        if @unit == 'percent'
          sum = row.sum
          row = row.map{|n| ("%.2f" % ((n.to_f/sum.to_f)*100.0)).to_f}
        end
        row.unshift(bar_name) # label each row
        @data << row
      end
    end

  end

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

end
