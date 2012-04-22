require 'PGMigration'

class AddAvailabilityIdToTransactions < ActiveRecord::Migration
  include PGMigration
  
  def up
    add_column :transactions, :availability_id, :integer, null: false
    add_foreign_key :transactions, :availability_id, :availabilities
  end

  def down
    drop_foreign_key :transactions, :availability_id, :availabilities
    remove_column :transactions, :availability_id
  end
end
