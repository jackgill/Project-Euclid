require 'PGMigration'

class MoveUserPreferences < ActiveRecord::Migration
  include PGMigration
  
  def up
    drop_table :user_preferences
    add_column :users, :notify_new_request, :boolean, null: false, default: false
    add_column :users, :notify_new_listing, :boolean, null: false, default: false
    add_column :users, :building_id, :integer, null: false, default: 0
    add_foreign_key(:users, :building_id, :buildings)
  end

  def down
    # hahaha
  end
end
