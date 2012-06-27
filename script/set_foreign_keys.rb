# rails console
# load 'script/set_foreign_keys.rb

ActiveRecord::Base.establish_connection

def execute(string)
  begin
    ActiveRecord::Base.connection.execute(string)
  rescue
    puts "Warning: unable to execute " + string
  end
end

def add_foreign_key(from_table, from_column, to_table)
    constraint_name = "fk_#{from_table}_#{from_column}"
    
    execute %{ALTER TABLE #{from_table}
              ADD CONSTRAINT #{constraint_name}
              FOREIGN KEY (#{from_column})
              REFERENCES #{to_table}(id)}
end

add_foreign_key('Spots', 'owner_id', 'Users')
add_foreign_key('Spots', 'building_id', 'Buildings')
add_foreign_key('Listings', 'lister_id', 'Users')
add_foreign_key('Listings', 'spot_id', 'Spots')
add_foreign_key('Listings', 'building_id', 'Buildings')
add_foreign_key('Requests', 'requester_id', 'Users')
add_foreign_key('Requests', 'building_id', 'Buildings')
add_foreign_key('Transactions', 'spot_id', 'Spots')
add_foreign_key('Transactions', 'seller_id', 'Users')
add_foreign_key('Transactions', 'buyer_id', 'Users')
add_foreign_key('Transactions', 'availability_id', 'Availabilities')
add_foreign_key('Availabilities', 'listing_id', 'Listings')
add_foreign_key('Availabilities', 'building_id', 'Buildings')
add_foreign_key('Users', 'building_id', 'Buildings')
