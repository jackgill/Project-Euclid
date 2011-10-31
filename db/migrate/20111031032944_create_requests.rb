class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :requester_id, :null => false, :options => "references users(id)"
      t.date :start_date
      t.date :end_date
      t.decimal :bid_price

      t.timestamps
    end
  end
end
