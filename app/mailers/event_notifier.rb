class EventNotifier < ActionMailer::Base
  default from: "champa@jackmgill.com"

  def new_request(request, subscribers)
    @request = request

    for email in subscribers
      mail to: email, subject: "New request on project champa"
    end
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_notifier.new_listing.subject
  #
  def new_listing
    @greeting = "Hi"

    mail to: "to@example.org"
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
end
