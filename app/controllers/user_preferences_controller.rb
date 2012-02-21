class UserPreferencesController < ApplicationController
  before_filter :find_prefs, only: [ :show, :edit, :update ]
  before_filter :require_owner_or_admin, only: [ :edit, :update ]
  
  def show
  end

  def edit
    @prefs = UserPreference.find(params[:id])
  end

  def update
    respond_to do |format|
      if @prefs.update_attributes(params[:user_preference])
        format.html { redirect_to @prefs, notice: "Preferences were successfully updated" }
      else
        format.html { redirect_to @prefs, notice: "Error updating preferences" }
      end
    end
  end

  def find_prefs
    @resource = @prefs = UserPreference.find(params[:id])
  end
end
