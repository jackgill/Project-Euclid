class TransactionCancelledEvent < Event
  def initialize(transaction, canceller)
    @transaction = transaction
    @canceller = canceller
  end

  def notify()
    EventNotifier.transaction_cancelled(@transaction, @canceller).deliver
  end
end
