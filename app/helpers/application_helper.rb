module ApplicationHelper

  def get_name(user)
    if user
      return user.first_name + ' ' + user.last_name
    else
      return 'guest'
    end
  end
end
