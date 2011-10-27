class SpotBuildingRelationship < ActiveRecord::Migration
  def up
    remove_column :spots, :building_id
    add_column :spots, :building_id, :integer, :null => false, :default => 0, :options => "CONSTRAINT fk_buildings REFERENCES buildings(id)"
  end

  def down
    remove_column :spots, :building_id
  end
end
