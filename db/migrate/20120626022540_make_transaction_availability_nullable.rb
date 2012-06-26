class MakeTransactionAvailabilityNullable < ActiveRecord::Migration
  def up
    change_column :transactions, :availability_id, :integer, null: true
  end

  def down
    change_column :transactions, :availability_id, :integer, null: false
  end
end
