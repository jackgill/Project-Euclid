class EventNotifier < ActionMailer::Base
  default from: "Project Champa <champa@jackmgill.com>"

  @@subjects = {
    new_request: "New request on Project Champa",
    new_listing: "New listing on Project Champa",
    listing_fulfilled_buyer: "You have reserved a spot on Project Champa",
    listing_fulfilled_seller: "Your spot has been rented on Project Champa",
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

  def listing_fulfilled_buyer(listing, subscribers)
    @listing = listing
    mail_subscribers(subscribers, @@subjects[:listing_fulfilled_buyer])
  end

  def listing_fulfilled_seller(listing, subscribers)
    @listing = listing
    mail_subscribers(subscribers, @@subjects[:listing_fulfilled])
  end
  
  def request_fulfilled
    @greeting = "Hi"

    mail to: "to@example.org"
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
