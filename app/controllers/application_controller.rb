class ApplicationController < ActionController::Base
  protect_from_forgery

def authorize
  if ENV['SESSIONKEY'].blank?
    flash[:notice] = 'Session key missing'
    redirect_to :controller => 'admin', :action => 'login'
    return(false)
  end
  if session[:key] == ENV['SESSIONKEY']
    return(true)
  else
    flash[:notice] = 'Not logged in'
    redirect_to :controller => 'admin', :action => 'login'
    return(false)
  end
end
  
end
