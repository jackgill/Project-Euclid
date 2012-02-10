class UserPreferencesController < ApplicationController
  def show
    @prefs = @user.user_preference
  end

  def edit
    @prefs = UserPreference.find(params[:id])
  end

  def update
    @prefs = UserPreference.find(params[:id])
    respond_to do |format|
      if @prefs.update_attributes(params[:user_preference])
        format.html { redirect_to @prefs, notice: "Preferences were successfully updated" }
      else
        format.html { redirect_to @prefs, notice: "Error updating preferences" }
      end
    end
  end

end
