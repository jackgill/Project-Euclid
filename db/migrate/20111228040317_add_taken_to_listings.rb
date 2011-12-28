class AddTakenToListings < ActiveRecord::Migration
  def change
    add_column :listings, :taken, :boolean, :null => false, :default => 'FALSE'
  end
end
