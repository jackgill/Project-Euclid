class CreateAvailabilitiesArchive < ActiveRecord::Migration
  def change
    create_table :availabilities_archive do |t|
      t.integer :listing_id
      t.date :start_date
      t.date :end_date
      t.timestamps
      t.integer :building_id
    end
  end
end
