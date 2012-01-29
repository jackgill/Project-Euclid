require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  test "cascading deletes" do
    listing = listings(:one)
    listing.destroy
    assert_equal 0, listing.availability.length
  end
end
