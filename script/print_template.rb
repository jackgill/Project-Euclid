transaction = Transaction.first

puts EventNotifier.listing_fulfilled_buyer(transaction)
puts EventNotifier.listing_fulfilled_seller(transaction)
puts EventNotifier.request_fulfilled_buyer(transaction)
puts EventNotifier.request_fulfilled_seller(transaction)



