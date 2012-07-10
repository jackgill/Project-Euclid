class AddCancelledToListings < ActiveRecord::Migration
  def change
    add_column :listings, :cancelled, :boolean, null: false, default: 'FALSE'
  end
end
