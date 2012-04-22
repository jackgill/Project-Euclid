class Availability < ActiveRecord::Base
  belongs_to :listing
  belongs_to :building
  has_one :transaction
  
  validates(:listing_id,
            :building_id,
            :start_date,
            :end_date,
            :presence => true)
  #TODO: validate end_date > start_date

  def rent(rental_start_date, rental_end_date, buyer, seller)
    if rental_start_date == nil
      raise Exception("Rental start date is nil")
    end

    if buyer.id == seller.id
      raise Exceptions::UserFacingException.new("Oops! You can't rent your own spot.")
    end
    
    # mark this availability as taken
    self.taken = true
    return [ false ] unless save
    
    # create up to two new availability objects to represent
    # the remaining availability for this listing

    # rental period is in the middle of availability
    if start_date < rental_start_date && end_date > rental_end_date

      create_earlier_availability rental_start_date
      create_later_availability rental_end_date
    # rental period is the beginning of availability
    elsif start_date == rental_start_date && end_date > rental_end_date
      create_later_availability rental_end_date
    # rental period is the end of availability
    elsif start_date < rental_start_date && end_date == rental_end_date
      create_earlier_availability rental_start_date
    end
    
    # create a new transaction between the buyer and the seller
    create_transaction(rental_start_date, rental_end_date, buyer, seller)
  end

  def restore()
    # Mark availability as not taken
    self.taken = false
    return false unless save

    # TODO: join on adjoining availability
  end

  private
  
  def create_earlier_availability(rental_start_date)
    earlier_availability = Availability.new(
                                              listing_id: listing_id,
                                              building_id: building_id,
                                              start_date: start_date,
                                              end_date: rental_start_date,
                                              )
      earlier_availability.save
  end

  def create_later_availability(rental_end_date)
    later_availability = Availability.new(
                                          listing_id: listing_id,
                                          building_id: building_id,
                                          start_date: rental_end_date,
                                          end_date: end_date,
                                          )
    later_availability.save
  end

  def create_transaction(rental_start_date, rental_end_date, buyer, seller)
    transaction = Transaction.new(
                                  spot_id: listing.spot.id,
                                  buyer_id: buyer.id,
                                  seller_id: seller.id,
                                  start_date: rental_start_date,
                                  end_date: rental_end_date,
                                  price: listing.ask_price,
                                  availability_id: self.id
                                  )
    return transaction.save, transaction
  end
end
