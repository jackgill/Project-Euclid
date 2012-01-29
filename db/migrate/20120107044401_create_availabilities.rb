require 'PGMigration'

class CreateAvailabilities < ActiveRecord::Migration
  include PGMigration
  def change
    create_table :availabilities do |t|
      t.integer :listing_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end

    add_foreign_key(:availabilities, :listing_id, :listings)
  end
end
