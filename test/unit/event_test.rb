require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "new request subscribers" do
    event = NewRequestEvent.new requests(:one)
    subscribers = event.get_subscribers
    assert_equal subscribers.sort, [ users(:alice), users(:admin) ].sort
  end

  test "new listing subscribers" do
    event = NewListingEvent.new listings(:one)
    subscribers = event.get_subscribers
    assert_equal subscribers.sort, [ users(:bob), users(:admin) ].sort
  end
end
