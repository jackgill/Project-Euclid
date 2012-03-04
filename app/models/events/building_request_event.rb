class BuildingRequestEvent < Event

  def initialize(building, email)
    @building = building
    @email = email
  end

  def get_subscribers()
    return User.where("is_admin = ?", true)
  end

  def notify()
    subscribers = get_subscribers()
    EventNotifier.request_fufilled(@request, subscribers).deliver
  end
end
