class HouseholdsController < ApplicationController

  def index
    @count = Household.count
  end

  def chart
    @x_axis_options = Household.x_field_names
    @y_axis_options = Household.y_field_names
    @units_options = ['percent', 'number of answers']
    @stack_options = ['stacked bars', 'unstacked']
    if request.post?
      @y_type = Household.columns_hash[params[:y].to_s].type
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
