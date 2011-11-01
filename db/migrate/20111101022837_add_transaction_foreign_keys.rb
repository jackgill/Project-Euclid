require File.dirname(__FILE__) + '/../../app/models/PGMigration.rb'

class AddTransactionForeignKeys < PGMigration
  def up
    foreign_key('Transactions', 'spot_id', 'Spots')
    foreign_key('Transactions', 'seller_id', 'Users')
    foreign_key('Transactions', 'buyer_id', 'Users')
  end

  def down
    drop_foreign_key('Transactions', 'spot_id', 'Spots')
    drop_foreign_key('Transactions', 'seller_id', 'Users')
    drop_foreign_key('Transactions', 'buyer_id', 'Users')
  end
end
