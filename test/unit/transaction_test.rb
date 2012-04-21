require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "cancel transaction" do
    transaction = transactions(:one)
    transaction.cancel()

    assert_equal false, transaction.availability.taken, "Availability was marked as not taken"
    assert_equal true, transaction.cancelled, "Transaction was marked as cancelled"
  end
end
