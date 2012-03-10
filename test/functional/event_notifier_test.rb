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

  test "listing_fulfilled_buyer" do
    transaction = transactions(:one)
    
    mail = EventNotifier.listing_fulfilled_buyer(transaction)

    assert_equal EventNotifier.subjects[:new_transaction_buyer], mail.subject
    assert_equal [transaction.buyer.email], mail.to
    assert_equal [from_address], mail.from
    assert_match "You reserved a parking spot on Project Champa!", mail.body.encoded
  end

  test "listing_fulfilled_seller" do
    transaction = transactions(:one)
    
    mail = EventNotifier.listing_fulfilled_seller(transaction)

    assert_equal EventNotifier.subjects[:new_transaction_seller], mail.subject
    assert_equal [transaction.seller.email], mail.to
    assert_equal [from_address], mail.from
    assert_match "Someone reserved your parking spot on Project Champa!", mail.body.encoded
  end

  test "request_fulfilled_buyer" do
    transaction = transactions(:one)
    
    mail = EventNotifier.request_fulfilled_buyer(transaction)

    assert_equal EventNotifier.subjects[:new_transaction_buyer], mail.subject
    assert_equal [transaction.buyer.email], mail.to
    assert_equal [from_address], mail.from
    assert_match "Someone fulfilled your request for a parking spot on Project Champa!", mail.body.encoded
  end

  test "request_fulfilled_seller" do
    transaction = transactions(:one)
    
    mail = EventNotifier.request_fulfilled_seller(transaction)

    assert_equal EventNotifier.subjects[:new_transaction_seller], mail.subject
    assert_equal [transaction.seller.email], mail.to
    assert_equal [from_address], mail.from
    assert_match "You fulfilled a request for a parking spot on Project Champa!", mail.body.encoded
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
