require 'test_helper'

class SpotTest < ActiveSupport::TestCase
  test "can create unique spot" do
    spot = spots(:one)
    unique_spot = Spot.new(spot.attributes)
    unique_spot.number += 1
    assert unique_spot.valid?
  end

  test "cannot create duplicate spot" do
    spot = spots(:one)
    duplicate_spot = Spot.new(spot.attributes)
    assert !duplicate_spot.valid?
  end
end
