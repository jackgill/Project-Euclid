require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test "cancel transaction" do
    transaction = transactions(:one)
    transaction.cancel()

    assert_equal false, transaction.availability.taken, "Availability was marked as not taken"
  end
end
