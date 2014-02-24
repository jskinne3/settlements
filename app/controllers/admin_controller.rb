class AdminController < ApplicationController

  #before_filter :authorize, :except => [:authorize, :login, :logout]

  def login
    if request.post?
      if params[:key].blank?
        flash[:notice] = 'No key entered.'
      else
        if (params[:key].strip == ENV['Ckey'] or params[:key].strip == ENV['Bkey'])
          flash[:notice] = 'Key accepted for login.'
          session[:key] = ENV['SESSIONKEY']
          redirect_to :controller => 'households', :action => 'chart'
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

end
