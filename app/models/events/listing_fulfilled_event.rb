class ListingFulfilledEvent < Event
  def initialize(transaction)
    @transaction = transaction
  end

  def notify()
    EventNotifier.listing_fulfilled_buyer(@transaction).deliver
    EventNotifier.listing_fulfilled_seller(@transaction).deliver
  end
end
