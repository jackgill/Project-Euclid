class AddNotificationSettingsToUserPreferences < ActiveRecord::Migration
  def change
    add_column :user_preferences, :notify_new_request, :boolean
    add_column :user_preferences, :notify_new_listing, :boolean
  end
end
