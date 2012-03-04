class ListingFulfilledEvent < Event

  def initialize(listing, fulfiller)
    @listing = listing
    @fulfiller = fulfiller
  end

  def get_subscribers()
    return [ @listing.lister, @fulfiller ]
  end

  def notify()
    subscribers = get_subscribers()
    EventNotifier.listing_fufilled(@request, subscribers).deliver
  end
end
