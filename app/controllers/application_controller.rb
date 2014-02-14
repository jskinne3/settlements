class ApplicationController < ActionController::Base
  protect_from_forgery

def authorize
  if session[:key] == 'hK78tsq$55.2y9'
    return(true)
  else
    flash[:notice] = 'Not logged in'
    redirect_to :controller => 'admin', :action => 'login'
    return(false)
  end
end
  
end
