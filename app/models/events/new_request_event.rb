class NewRequestEvent < Event
  attr_accessor :request

  def initialize(request)
    @request = request
  end

  def get_subscribers()
    return User.where("notify_new_request = ?", true)
  end

  def notify()
    subscribers = get_subscribers()
    EventNotifier.new_request(@request, subscribers).deliver
  end
end
