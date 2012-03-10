class RequestFulfilledEvent < Event
  def initialize(transaction)
    @transaction = transaction
  end

  def notify()
    EventNotifier.request_fulfilled_buyer(@transaction).deliver
    EventNotifier.request_fulfilled_seller(@transaction).deliver
  end
end
