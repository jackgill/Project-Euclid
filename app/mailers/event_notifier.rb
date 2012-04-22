class EventNotifier < ActionMailer::Base
  default from: "Project Champa <champa@jackmgill.com>"
  add_template_helper(ApplicationHelper)
  
  @@subjects = {
    new_request: "New request on Project Champa",
    new_listing: "New listing on Project Champa",
    new_transaction_buyer: "You have rented a parking spot on Project Champa",
    new_transaction_seller: "Your parking spot has been rented on Project Champa",
    cancelled_transaction: "Transaction cancelled on Project Champa",
  }

  def self.subjects
    @@subjects
  end
  
  def new_request(request, subscribers)
    @request = request
    mail_subscribers(subscribers, @@subjects[:new_request])
  end

  def new_listing(listing, subscribers)
    @listing = listing
    mail_subscribers(subscribers, @@subjects[:new_listing])
  end

  def listing_fulfilled_buyer(transaction)
    @greeting = "Hi #{transaction.buyer.first_name},"
    @message = "You reserved a parking spot on Project Champa!"
    @transaction = transaction
    mail(to: transaction.buyer.email,
         subject: @@subjects[:new_transaction_buyer],
         template_name: 'new_transaction')
  end

  def listing_fulfilled_seller(transaction)
    @greeting = "Hi #{transaction.seller.first_name},"
    @message = "Someone reserved your parking spot on Project Champa!"
    @transaction = transaction
    mail(to: transaction.seller.email,
         subject: @@subjects[:new_transaction_seller],
         template_name: 'new_transaction')
  end
  
  def request_fulfilled_buyer(transaction)
    @greeting = "Hi #{transaction.buyer.first_name},"
    @message = "Someone fulfilled your request for a parking spot on Project Champa!"
    @transaction = transaction
    mail(to: transaction.buyer.email,
         subject: @@subjects[:new_transaction_buyer],
         template_name: 'new_transaction')
  end

  def request_fulfilled_seller(transaction)
    @greeting = "Hi #{transaction.seller.first_name},"
    @message = "You fulfilled a request for a parking spot on Project Champa!"
    @transaction = transaction
    mail(to: transaction.seller.email,
         subject: @@subjects[:new_transaction_seller],
         template_name: 'new_transaction')
  end

  def transaction_cancelled(transaction, canceller)
    # figure out which party cancelled the transaction
    cancellee = transaction.buyer
    if canceller.id == transaction.buyer.id
      cancellee = buyer
    end
    
    @greeting = "Hi #{cancellee.first_name},"
    @message = "A transaction you were involved in has been cancelled:"
    @transaction = transaction
    mail(to: cancellee.email,
         subject: @@subjects[:cancelled_transaction],
         template_name: 'transaction_cancelled')
  end

  def building_request
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def transaction_reminder
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  private

  def mail_subscribers(subscribers, subject)
    for subscriber in subscribers
      @user = subscriber
      mail to: subscriber.email, subject: subject
    end
  end
end
