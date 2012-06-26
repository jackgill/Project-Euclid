class RemoveLoginFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :login
  end

  def down
    add_column :users, :login, :string
  end
end
