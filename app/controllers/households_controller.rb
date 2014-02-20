class HouseholdsController < ApplicationController

  def index
    @count = Household.count
  end

  def chart
    @x_axis_options = Household.x_field_names
    @y_axis_options = Household.y_field_names
    @units_options = ['percent', 'number of answers']
    @stack_options = ['stacked bars', 'unstacked']
    x = params[:x] # TODO: Clean inputs to prevent SQL injection
    y = params[:y]
    if (request.post? or params[:graphed] == '1')
      @chart_title = "#{params[:y]} in each #{params[:x]}"
      @y_type = Household.columns_hash[y.to_s].type
      @chart_type = (@y_type.to_s == 'integer' or @y_type.to_s == 'float') ? 'line' : 'bar'
      hh_data = Household.where("#{x} IS NOT NULL") # TODO: Add filtering
      possible_answers = hh_data.map{|d| d[y.to_sym]}.uniq
      @chart_table = Array.new
      intervals = hh_data.map{|d| d[x.to_sym]}.uniq.sort
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
        else
          for answer in possible_answers
            row << data_in_interval.select{|d| d[y.to_sym] == answer}.count
          end
          if params[:units] == 'percent'
            sum = row.sum.to_f
            row = row.map{|n| ("%.2f" % ((n.to_f/sum)*100.0)).to_f}
          end
        end
        row.unshift(interval) # Label rows
        @chart_table << row
      end
      if @chart_type == 'bar'
        @chart_table.unshift([y]+possible_answers.map{|a| a.blank? ? 'N/A' : a.to_s}) # Label bars/columns
      end
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
