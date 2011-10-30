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
end
