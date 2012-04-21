require 'PGMigration'

class AddAvailabilityIdToTransactions < ActiveRecord::Migration
  include PGMigration
  
  def change
    add_column :transactions, :availability_id, :integer
    add_foreign_key :transactions, :availability_id, :availabilities
  end
end
