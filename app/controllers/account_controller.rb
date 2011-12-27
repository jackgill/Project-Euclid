class AccountController < ApplicationController
  def login
    if request.post?
      user = User.authenticate(params[:login], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to(:controller => "home", :action => "index")
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = :logged_out
    flash[:notice] = "logged out"
    redirect_to(:action => "login")
  end
end
