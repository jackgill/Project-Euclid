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
end
