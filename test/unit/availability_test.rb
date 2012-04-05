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
    original_availability = availabilities(:one)

    rental_start_date = original_availability.start_date + 2
    rental_end_date = original_availability.end_date - 2

    original_availability.rent(rental_start_date, rental_end_date, buyer, seller)

    # The original availability was marked as taken
    assert_equal true, original_availability.taken

    availabilities = Availability.where(listing_id: original_availability.listing_id, taken: false)

    # Two new availabilities were created
    assert_equal 2, availabilities.length, 'Two new availabilities were created'

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
    assert_equal 1, transactions.length
  end
  
  test "rent beginning of availability" do
    # A user rents the beginning of an availability

    buyer = users(:bob)
    seller = users(:alice)
    original_availability = availabilities(:one)

    rental_start_date = original_availability.start_date
    rental_end_date = original_availability.start_date + 2

    original_availability.rent(rental_start_date, rental_end_date, buyer, seller)

    # The original availability was marked as taken
    assert_equal true, original_availability.taken

    # The later availability was created
    availabilities = Availability.where(listing_id: original_availability.listing_id, taken: false)
    
    # One new availability was created
    assert_equal 1, availabilities.length, "Earlier availability was created"

    # The later availability was created correctly
    later_availability = availabilities[0]
    assert_equal later_availability.start_date, rental_end_date, "Later availability start date"
    assert_equal later_availability.end_date, original_availability.end_date, "Later availability end date"

    # A transaction was created
    transactions = Transaction.where(
                                     start_date: rental_start_date,
                                     end_date: rental_end_date)
    assert_equal 1, transactions.length

  end

  test "rent end of availability" do
    # A user rents the end of an availability

    buyer = users(:bob)
    seller = users(:alice)
    original_availability = availabilities(:one)

    rental_start_date = original_availability.start_date + 2
    rental_end_date = original_availability.end_date

    original_availability.rent(rental_start_date, rental_end_date, buyer, seller)

    # The original availability was marked as taken
    assert_equal true, original_availability.taken

    # The earlier availability was created
    availabilities = Availability.where(listing_id: original_availability.listing_id, taken: false)

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
    assert_equal 1, transactions.length
  end

  test "rent all of an availability" do
    # A user rents all of an availability

    buyer = users(:bob)
    seller = users(:alice)
    original_availability = availabilities(:one)

    rental_start_date = original_availability.start_date
    rental_end_date = original_availability.end_date

    success, transaction = original_availability.rent(rental_start_date, rental_end_date, buyer, seller)

    assert_equal true, success
    
    # The original availability was marked as taken
    assert_equal true, original_availability.taken

    availabilities = Availability.where(:listing_id => original_availability.listing_id)

    # No new availabilities were created
    assert_equal availabilities.length, 1

    transactions = Transaction.where(
                                     start_date: rental_start_date,
                                     end_date: rental_end_date)
    assert_equal 1, transactions.length
  end

  test "User cannot rent their own availability" do
    buyer = users(:bob)
    seller = buyer # this should not be possible
    
    original_availability = availabilities(:one)

    rental_start_date = original_availability.start_date + 2
    rental_end_date = original_availability.end_date

    assert_raise Exceptions::UserFacingException do
      original_availability.rent(rental_start_date, rental_end_date, buyer, seller)
    end
  end
end
