class AddForeignKeys < ActiveRecord::Migration
  def up
    foreign_key('Spots', 'owner_id', 'Users')
    foreign_key('Spots', 'building_id', 'Buildings')
    foreign_key('Listings', 'lister_id', 'Users')
    foreign_key('Listings', 'spot_id', 'Spots')
    foreign_key('Requests', 'requester_id', 'Users')
  end

  def down
    drop_foreign_key('Spots', 'owner_id', 'Users')
    drop_foreign_key('Spots', 'building_id', 'Buildings')
    drop_foreign_key('Listings', 'lister_id', 'Users')
    drop_foreign_key('Listings', 'spot_id', 'Spots')
    drop_foreign_key('Requests', 'requester_id', 'Users')
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
