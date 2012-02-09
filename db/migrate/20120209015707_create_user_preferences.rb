require 'PGMigration'

class CreateUserPreferences < ActiveRecord::Migration
  include PGMigration
  
  def change
    create_table :user_preferences do |t|
      t.integer :user_id
      t.integer :building_id
      t.timestamps
    end

    add_foreign_key(:user_preferences, :building_id, :buildings)
  end
end
