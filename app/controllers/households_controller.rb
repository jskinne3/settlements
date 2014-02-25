class HouseholdsController < ApplicationController

  before_filter :authorize

  def index
    @count = Household.count
  end

  def combo_test
    @questions = Household.y_field_names
    params[:q] ||= 'inc_bw_no'
    @array = Array.new
    @hh_data = Household.where("#{params[:q]} IS NOT NULL")
    @areas = @hh_data.map{|d| d.area}.uniq
    @rnds = @hh_data.map{|d| d.rnd}.uniq
    @array << ['Round']+@areas+['Average']
    for rnd in @rnds
      row, row_numbers = [rnd], Array.new
      for area in @areas
        data_for_cell = @hh_data.select{|i| i.area == area && i.rnd == rnd}
        incomes = data_for_cell.map{|e| e[params[:q].to_sym]}
        if incomes.length > 0
          avg = (incomes.sum / incomes.length.to_f).round(2)
          row << avg
          row_numbers << avg
        else
          row << 'null'
        end
      end
      row << (row_numbers.sum/row_numbers.length).round(2)
      @array << row
    end
  end

  def chart
    # Drop-down menu options
    @x_axis_options = Household.x_field_names
    @y_axis_options = Household.y_field_names
    @units_options  = {'Percent' => 'p', 'Number of answers' => 'n'}
    @stack_options  = {'Stacked bars' => 's', 'Unstacked' => 'u'}
    @city_options   = {'Both cities' => 'all', 'Nairobi' => 'nairobi', 'Kisumu' => 'kisumu' }
    @area_options   = {'General' => {'All areas' => 'all'}, 'Nairobi' => {'Mukuru' => 'muk', 'Korogocho' => 'kor', 'Viwandani' => 'viw'}, 'Kisumu' => {'Nyalenda' => 'nya', 'Obunga' => 'obu'}}
    @rnd_options    = {'All rounds' => 'all', 'Round 5' => 'R5', 'Round 6' => 'R6', 'Round 7' => 'R7', 'Round 8' => 'R8'}
    # Drop-down menu defaults
    params[:area]  ||= 'all'
    params[:rnd]   ||= 'all'
    params[:units] ||= 'p'
    params[:stack] ||= 's'
    params[:std]   ||= 1
    params[:x]     ||= 'inc_all_q5'
    params[:y]     ||= 'q9_1'
    # When the user asks for data to be charted
    if (request.post? or params[:graphed] == '1')
      x, y = params[:x], params[:y] # TODO: Clean inputs to prevent SQL injection
      @y_type = Household.columns_hash[y.to_s].type
      @chart_type = (@y_type.to_s == 'integer' or @y_type.to_s == 'float') ? 'line' : 'bar'
      filter_hash = Hash.new
      for p in [:city, :area, :rnd]
        filter_hash = filter_hash.merge(p => params[p]) unless params[p] == 'all'
      end
      hh_data = Household.where("#{x} IS NOT NULL").where(filter_hash)
      @count = hh_data.length
      possible_answers = hh_data.map{|d| d[y.to_sym]}.uniq
      @chart_table = Array.new
      intervals = hh_data.map{|d| d[x.to_sym]}.uniq.sort
      # Calculations for every row in output table, i.e., every interval on the x-axis
      for interval in intervals
        row = Array.new
        data_in_interval = hh_data.select{|d| d[x.to_sym] == interval}
        if @chart_type == 'line'
          datapoints = data_in_interval.map{|q| q[y.to_sym] }.compact
          sum, n = datapoints.sum, datapoints.length.to_f
          mean = sum / n
          row = [mean.round(2)]
          if params[:std] == '1'
            variance = datapoints.map{|i| (i-mean)**2 }.sum / n
            std_deviation = Math.sqrt(variance)
            row << (mean+(std_deviation/2.0)).round(2)
            row << (mean-(std_deviation/2.0)).round(2)
          end
          if params[:med] == '1'
            sorted = datapoints.sort
            row << ((sorted[(n - 1) / 2] + sorted[n / 2.0]) / 2.0).round(2)
          end
        else
          # Calculations for every cell in a row, i.e., every colored region in a single bar
          for answer in possible_answers
            row << data_in_interval.select{|d| d[y.to_sym] == answer}.count
          end
          if params[:units] == 'p' # Calculate percents
            sum = row.sum.to_f
            row = row.map{|n| ("%.2f" % ((n.to_f/sum)*100.0)).to_f}
          end
        end
        row.unshift(interval) # Label rows
        @chart_table << row
      end
      if @chart_type == 'bar'
        @chart_table.unshift([y]+possible_answers.map{|a| a.nil? ? 'N/A' : a.to_s}) # Label bars/columns
      end
      # Notes on how to calculate P-value with R
      #require 'rubygems'
      #require 'rinruby'
      #R.eval 'x <- read.csv("~/concern/public/john.csv")'
      #R.eval "y <- table(x$#{@bar_meaning}, x$#{@question})"
      #R.eval 'p <- chisq.test(y)$p.value'
      #@pvalue = R.pull 'p'
      @pvalue = 0.001 # Fake p-value for now
    end
  end

  def list
    @count = Household.count
    @households = Household.all
  end

  def import
    if request.post?
      unless params[:file]
        flash[:notice] = "No file selected."
        return
      else
        flash[:notice] = nil
      end
      Household.import(params[:file])
      flash[:notice] = "Imported #{params[:file].original_filename}"
    else
      flash[:notice] = nil
    end
    @count = Household.count
  end

  def delete_all
    first_count = Household.count
    if request.post?
      for q in Household.all
        q.delete
      end
      @count = Household.count
      flash[:notice] = "Household table decreased by #{first_count - @count} rows."
    else
      @count = Household.count
      flash[:notice] = nil
    end
  end

end
