class RequestFulfilledEvent < Event

  def initialize(request, fulfiller)
    @request = request
    @fulfiller = fulfiller
  end

  def get_subscribers()
    return [ @request.requester, @fulfiller ]
  end

  def notify()
    subscribers = get_subscribers()
    EventNotifier.request_fufilled(@request, subscribers).deliver
  end
end
