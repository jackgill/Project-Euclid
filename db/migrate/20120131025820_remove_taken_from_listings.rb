class RemoveTakenFromListings < ActiveRecord::Migration
  def up
    remove_column :listings, :taken
  end

  def down
    add_column :listings, :taken, :boolean, :null => false, :default => 'FALSE'
  end
end
