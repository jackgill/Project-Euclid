class UserPreference < ActiveRecord::Base
  belongs_to :user
  belongs_to :building

  def is_owner(user)
    return user.id == user_id
  end
end
