class TransactionReminderEvent < Event

  def initialize(transaction)
    @transaction = transaction
  end

  def get_subscribers()
    return [ @transaction.buyer, @transaction.seller ]
  end

  def notify()
    subscribers = get_subscribers()
    EventNotifier.request_fufilled(@request, subscribers).deliver
  end
end
