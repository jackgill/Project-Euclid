class AdminController < ApplicationController
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
    redirect_to controller: 'admin', action: 'index', notice: 'Session Cleared'
  end
end
