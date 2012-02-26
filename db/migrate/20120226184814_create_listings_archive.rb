class CreateListingsArchive < ActiveRecord::Migration
  def change
    create_table :listings_archive do |t|
      t.integer :lister_id
      t.integer :spot_id
      t.date :start_date
      t.date :end_date
      t.decimal :ask_price
      t.timestamps
      t.integer :building_id
    end
  end
end
