class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :lister_id
      t.integer :spot_id
      t.date :start_date
      t.date :end_date
      t.decimal :ask_price

      t.timestamps
    end
  end
end
