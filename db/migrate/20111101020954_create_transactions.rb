class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :spot_id
      t.integer :buyer_id
      t.integer :seller_id
      t.date :start_date
      t.date :end_date
      t.decimal :price

      t.timestamps
    end
  end
end
