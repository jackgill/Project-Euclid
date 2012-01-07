require 'PGMigration'

class AddBuildingIdToAvailabilitites < ActiveRecord::Migration
  include PGMigration
  
  def change
    add_column :availabilities, :building_id, :integer
    add_foreign_key(:availabilities, :building_id, :buildings)
  end
end
