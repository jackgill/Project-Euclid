class EventNotifier < ActionMailer::Base
  default from: "Project Champa <champa@jackmgill.com>"
  
  @@subjects = {
    new_request: "New request on Project Champa",
    new_listing: "New listing on Project Champa",
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

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_notifier.listing_fulfilled.subject
  #
  def listing_fulfilled
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_notifier.request_fulfilled.subject
  #
  def request_fulfilled
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_notifier.building_request.subject
  #
  def building_request
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_notifier.transaction_reminder.subject
  #
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
