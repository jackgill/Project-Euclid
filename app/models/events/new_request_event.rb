class NewRequestEvent < Event
  attr_accessor :request

  def initialize(request)
    @request = request
  end

  def get_subscribers()
    return UserPreference.where("notify_new_request = ?", true).map { |user_preference| user_preference.user }
  end

  def notify()
    subscribers = get_subscribers()
    EventNotifier.new_request(@request, subscribers).deliver
  end
end
