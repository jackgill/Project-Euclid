class AddTakenToAvailabilities < ActiveRecord::Migration
  def change
    add_column :availabilities, :taken, :boolean, null: false, default: false
  end
end
