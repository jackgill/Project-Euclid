require 'test_helper'

class RequestTest < ActiveSupport::TestCase
  test "fulfill request" do
    request = requests(:one)
    fulfiller = users(:alice)

    request.fulfill(fulfiller, spots(:one).id)

    # The request was deleted
    assert_raise ActiveRecord::RecordNotFound do
      Request.find(request.id)
    end

    # A transaction was created
    transactions = Transaction.where(
                                     start_date: request.start_date,
                                     end_date: request.end_date)
    assert_equal 1, transactions.length
  end
end
