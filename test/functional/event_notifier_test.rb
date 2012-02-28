require 'test_helper'

class EventNotifierTest < ActionMailer::TestCase
  test "new_request" do
    mail = EventNotifier.new_request
    assert_equal "New request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "new_listing" do
    mail = EventNotifier.new_listing
    assert_equal "New listing", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "listing_fulfilled" do
    mail = EventNotifier.listing_fulfilled
    assert_equal "Listing fulfilled", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "request_fulfilled" do
    mail = EventNotifier.request_fulfilled
    assert_equal "Request fulfilled", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "building_request" do
    mail = EventNotifier.building_request
    assert_equal "Building request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "transaction_reminder" do
    mail = EventNotifier.transaction_reminder
    assert_equal "Transaction reminder", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
