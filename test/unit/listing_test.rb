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
end
