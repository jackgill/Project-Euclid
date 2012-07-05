class AccountController < ApplicationController
  skip_before_filter :require_login
  skip_before_filter :require_building
  
  def login
    if request.post?
      user = User.authenticate(params[:login], params[:password])
      if user
        session[:user_id] = user.id
        if session[:requested_path]
          redirect_to session[:requested_path]
          session[:requested_path] = nil
        else
          redirect_to(:controller => "home", :action => "index")
        end
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = :logged_out
    reset_session
    flash[:notice] = "logged out"
    redirect_to(:action => "login")
  end
end
