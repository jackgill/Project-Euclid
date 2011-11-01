module ApplicationHelper

  def get_name(user)
    if user
      return user.first_name + ' ' + user.last_name
    else
      return 'guest'
    end
  end

  def format_user(user)
    if user
      return user.first_name + ' ' + user.last_name
    else
      return '--'
    end
  end

  def format_spot(spot)
    spot.building.name + ' ' + spot.number.to_s
  end
end
