class Building < ActiveRecord::Base
  has_many :spots
  has_many :listings
  has_many :availabilities
  has_many :requests
  has_many :user_preferences
end
