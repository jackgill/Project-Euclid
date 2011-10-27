class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.integer :building_id
      t.integer :number
      t.integer :floor
      t.integer :owner_id

      t.timestamps
    end
  end
end
