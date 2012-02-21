class AdminController < ApplicationController
  before_filter :require_admin
  
  def index
  end

  def jump
    @users = User.all
  end

  def impersonate
    _user = User.find_by_login(params[:user])
    session[:user_id] = _user.id
    redirect_to :controller => 'home', :action => 'index'
  end

  def clear_session
    reset_session
    flash[:notice] = 'Session Cleared'
    redirect_to controller: 'home', action: 'splash'
  end

  def require_admin
    unless @user && @user.is_admin
      session[:requested_path] = request.parameters
      flash[:notice] = "You must be an admin to view this page"
      redirect_to :action => 'login', :controller => 'account'
    end
  end
end
