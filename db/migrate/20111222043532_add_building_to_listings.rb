class AddBuildingToListings < ActiveRecord::Migration
  def up
    add_column :listings, :building_id, :integer
    foreign_key('Listings', 'building_id', 'Buildings')
  end

  def down
    drop_foreign_key('Listings', 'building_id', 'Buildings')
    remove_column :listings, :building_id
  end

  def foreign_key(from_table, from_column, to_table)
    constraint_name = "fk_#{from_table}_#{from_column}"
    
    execute %{ALTER TABLE #{from_table}
              ADD CONSTRAINT #{constraint_name}
              FOREIGN KEY (#{from_column})
              REFERENCES #{to_table}(id)}
  end

  def drop_foreign_key(from_table, from_column, to_table)
    constraint_name = "fk_#{from_table}_#{from_column}"
    
    execute %{ALTER TABLE #{from_table}
              DROP CONSTRAINT #{constraint_name}}
  end
end
