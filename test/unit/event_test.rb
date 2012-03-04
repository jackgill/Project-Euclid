require 'test_helper'

class EventTest < ActiveSupport::TestCase

  # When a new request is created, notify everyone
  # who has subscribed to be notified
  test "new request subscribers" do
    event = NewRequestEvent.new requests(:one)
    subscribers = event.get_subscribers
    assert_equal subscribers.sort, [ users(:alice), users(:admin) ].sort
  end

  # When a new listing is created, notify everyone
  # who has subscribed to be notified  
  test "new listing subscribers" do
    event = NewListingEvent.new listings(:one)
    subscribers = event.get_subscribers
    assert_equal subscribers.sort, [ users(:bob), users(:admin) ].sort
  end

  # When a listing is fulfilled, notify the lister
  # and the fulfiller
  test "listing fulfilled subscribers" do
    fulfiller = users(:alice)
    listing = listings(:one)
    event = ListingFulfilledEvent.new listing, fulfiller
    
    subscribers = event.get_subscribers

    assert_equal subscribers.sort, [ listing.lister, fulfiller ].sort
  end
  
  # When a request is fulfilled, notify the requester
  # and the fulfiller
  test "request fulfilled subscribers" do
    fulfiller = users(:alice)
    request = requests(:one)
    event = RequestFulfilledEvent.new request, fulfiller
    
    subscribers = event.get_subscribers
    
    assert_equal subscribers.sort, [ request.requester, fulfiller ].sort
  end

  # When a new building is requested, notify all the
  # admin users
  test "building request subscribers" do
    building = buildings(:spire)
    email = 'test@example.com'
    
    event = BuildingRequestEvent.new building, email
    
    subscribers = event.get_subscribers

    assert_equal subscribers.sort, [ users(:admin) ].sort
  end

  test "transaction reminder subscribers" do
    transaction = transactions(:one)
    event = TransactionReminderEvent.new transaction

    subscribers = event.get_subscribers

    assert_equal subscribers.sort, [ transaction.buyer, transaction.seller ].sort
  end
  
end
