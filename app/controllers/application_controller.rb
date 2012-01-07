class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :find_user

  private

  def find_user
    if session[:user_id] && session[:user_id] != :logged_out
      begin
        @user = User.find(session[:user_id])
        rescue ActiveRecord::RecordNotFound
        @user = nil
      end

    end
  end

  def require_login
    if @user == nil
      session[:requested_path] = Rails.application.routes.recognize_path request.env['PATH_INFO']
      redirect_to :action => 'login', :controller => 'account'
      return false
    end
    return true
  end

  def build_date_from_params(params)
    Date.new(params["date(1i)"].to_i, 
             params["date(2i)"].to_i, 
             params["date(3i)"].to_i)
  end

end
