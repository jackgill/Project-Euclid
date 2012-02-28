require_relative 'event.rb'

class NewListingEvent < Event
  attr_accessor :request

  def initialize(listing)
    @listing = listing
  end

  def get_subscribers()
    return UserPreference.where("notify_new_listing = ?", true).map { |user_preference| user_preference.user.email }
  end
end
