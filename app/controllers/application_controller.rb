class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :find_user
  before_filter :require_login
  before_filter :require_building
  
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
      session[:requested_path] = request.parameters
      redirect_to :action => 'login', :controller => 'account'
    end
  end

  def require_building
    # If we have a user, set the building from their preferences
    if @user != nil && @user.user_preference != nil
      @building = @user.user_preference.building
    else
      # If we don't have a user, check the session
      if session[:building_id] != nil
        # Set the building from the session
        @building = Building.find(session[:building_id])
        # TODO: error handling for building not being found?
      else
        # No user and no building in session, redirect to building select page
        session[:requested_path] = request.parameters
        redirect_to controller: 'home', action: 'building'
      end
    end
  end

  def build_date_from_params(params)
    Date.new(params["date(1i)"].to_i, 
             params["date(2i)"].to_i, 
             params["date(3i)"].to_i)
  end

  def message(message_text)
    flash[:message] = message_text
    redirect_to controller: 'home', action: 'message'
  end
end
