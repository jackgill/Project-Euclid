require 'test_helper'

class EventNotifierTest < ActionMailer::TestCase
  from_address = "champa@jackmgill.com"
  
  test "new_request" do
    request = requests(:one)
    user = users(:bob)
    mail = EventNotifier.new_request(request, [ user ])
    assert_equal EventNotifier.subjects[:new_request], mail.subject
    assert_equal [user.email], mail.to
    assert_equal [from_address], mail.from
    assert_match "new request", mail.body.encoded
  end

  test "new_listing" do
    listing = listings(:one)
    user = users(:bob)
    mail = EventNotifier.new_listing(listing, [ user ])
    assert_equal EventNotifier.subjects[:new_listing], mail.subject
    assert_equal [user.email], mail.to
    assert_equal [from_address], mail.from
    assert_match "new listing", mail.body.encoded
  end

  test "listing_fulfilled" do
    mail = EventNotifier.listing_fulfilled
    assert_equal "Listing fulfilled", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal [from_address], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "request_fulfilled" do
    mail = EventNotifier.request_fulfilled
    assert_equal "Request fulfilled", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal [from_address], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "building_request" do
    mail = EventNotifier.building_request
    assert_equal "Building request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal [from_address], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "transaction_reminder" do
    mail = EventNotifier.transaction_reminder
    assert_equal "Transaction reminder", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal [from_address], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
