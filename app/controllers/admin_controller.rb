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

  def rtest
    ls = %x(ls)
    r = %x(R -e "a <- c(2,3,5); mean(a)")
    render :text => "<html><body><h1>R test</h1><p>#{ls.inspect}</p><p>#{r.inspect}</p></body></html>"
  end

end
