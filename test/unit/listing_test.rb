require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  test "cascading deletes" do
    listing = listings(:one)
    listing.destroy
    assert_equal 0, listing.availability.length
  end

  test "is owner" do
    #puts "Bob: #{users(:bob).id}"
    #puts "Alice: #{users(:alice).id}"

    listing = listings(:one)
    assert listing.is_owner(users(:bob)), "Bob should be the owner"
    assert !listing.is_owner(users(:alice)), "Alice should not be the owner"
  end

  test "cannot create duplicate listing" do
    listing = listings(:one)
    duplicate_listing = Listing.new(listing.attributes)
    assert !duplicate_listing.valid?
  end

  test "can create unique listing" do
    listing = listings(:one)
    
    puts
    puts listing.attributes
    puts
    unique_listing = Listing.new(listing.attributes)
    unique_listing.start_date = listing.end_date + 1
    unique_listing.end_date = listing.end_date + 2
    assert unique_listing.valid?
  end
end
