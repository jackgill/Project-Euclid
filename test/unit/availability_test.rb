require 'test_helper'

class AvailabilityTest < ActiveSupport::TestCase
  def setup
    @original_availabilities_count = Availability.count
  end
  
  test "should not save empty availability" do
    availability = Availability.new
    assert !availability.save, "Saved empty availability"

  end

  test "rent middle of availability" do
    # A user rents a segment in the middle of the existing availability

    buyer = users(:bob)
    seller = users(:alice)
    rental_start_date = Date.new(2012, 1, 8)
    rental_end_date = Date.new(2012, 1, 10)

    original_availability = availabilities(:one)
    original_availability.rent(rental_start_date, rental_end_date, buyer, seller)

    # The original availability is deleted
    assert_raise ActiveRecord::RecordNotFound do
      Availability.find(original_availability.id)
    end

    # The earlier availability was created
    availabilities = Availability.where(:listing_id => original_availability.listing_id)

    # Two new availabilities were created
    assert_equal availabilities.length, 2

    # The earlier availability was created correctly
    earlier_availability = availabilities[0]
    assert_equal earlier_availability.start_date, original_availability.start_date, "Earlier availability start date"
    assert_equal earlier_availability.end_date, rental_start_date, "Earlier availability end date"

    # The later availability was created correctly
    later_availability = availabilities[1]
    assert_equal later_availability.start_date, rental_end_date, "Later availability start date"
    assert_equal later_availability.end_date, original_availability.end_date, "Later availability end date"

    # A transaction was created
    transactions = Transaction.where(
                                     start_date: rental_start_date,
                                     end_date: rental_end_date)
    assert_equal transactions.length, 1
  end
  
  test "rent beginning of availability" do
    # A user rents the beginning of an availability

    buyer = users(:bob)
    seller = users(:alice)
    rental_start_date = Date.new(2012, 1, 6)
    rental_end_date = Date.new(2012, 1, 10)

    original_availability = availabilities(:one)
    original_availability.rent(rental_start_date, rental_end_date, buyer, seller)

    # The original availability is deleted
    assert_raise ActiveRecord::RecordNotFound do
      Availability.find(original_availability.id)
    end

    # The later availability was created
    availabilities = Availability.where(:listing_id => original_availability.listing_id)

    # One new availability was created
    assert_equal availabilities.length, 1

    # The later availability was created correctly
    later_availability = availabilities[0]
    assert_equal later_availability.start_date, rental_end_date, "Later availability start date"
    assert_equal later_availability.end_date, original_availability.end_date, "Later availability end date"

    # A transaction was created
    transactions = Transaction.where(
                                     start_date: rental_start_date,
                                     end_date: rental_end_date)
    assert_equal transactions.length, 1

  end

  test "rent end of availability" do
    # A user rents the end of an availability

    buyer = users(:bob)
    seller = users(:alice)
    rental_start_date = Date.new(2012, 1, 8)
    rental_end_date = Date.new(2012, 1, 12)

    original_availability = availabilities(:one)
    original_availability.rent(rental_start_date, rental_end_date, buyer, seller)

    # The original availability is deleted
    assert_raise ActiveRecord::RecordNotFound do
      Availability.find(original_availability.id)
    end

    # The earlier availability was created
    availabilities = Availability.where(:listing_id => original_availability.listing_id)

    # One new availability was created
    assert_equal availabilities.length, 1

    # The earlier availability was created correctly
    earlier_availability = availabilities[0]
    assert_equal earlier_availability.start_date, original_availability.start_date, "Earlier availability start date"
    assert_equal earlier_availability.end_date, rental_start_date, "Earlier availability end date"
    
    # A transaction was created
    transactions = Transaction.where(
                                     start_date: rental_start_date,
                                     end_date: rental_end_date)
    assert_equal transactions.length, 1
  end

  test "rent all of an availability" do
    # A user rents all of an availability

    buyer = users(:bob)
    seller = users(:alice)
    rental_start_date = Date.new(2012, 1, 6)
    rental_end_date = Date.new(2012, 1, 12)

    original_availability = availabilities(:one)
    original_availability.rent(rental_start_date, rental_end_date, buyer, seller)

    # The original availability is deleted
    assert_raise ActiveRecord::RecordNotFound do
      Availability.find(original_availability.id)
    end

    availabilities = Availability.where(:listing_id => original_availability.listing_id)

    # No new availabilities were created
    assert_equal availabilities.length, 0

    transactions = Transaction.where(
                                     start_date: rental_start_date,
                                     end_date: rental_end_date)
    assert_equal transactions.length, 1
  end
end
