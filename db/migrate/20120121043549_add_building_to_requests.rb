require 'PGMigration'

class AddBuildingToRequests < ActiveRecord::Migration
  include PGMigration
  
  def change
    add_column :requests, :building_id, :integer

    add_foreign_key(:requests, :building_id, :buildings)
  end
end
