class UserPreferencesController < ApplicationController
  def show
    @prefs = @user.user_preference
  end

  def edit
  end

  def update
  end

end
