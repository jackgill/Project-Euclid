class AddDefaultUsers < ActiveRecord::Migration
  def up
    bob = User.new
    bob.first_name = 'bob'
    bob.last_name = 'LNU'
    bob.email = 'test@example.com'
    bob.login = 'bob'
    bob.password = 'bob'
    bob.save()
  end

  def down
  end
end
