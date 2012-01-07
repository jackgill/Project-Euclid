class Building < ActiveRecord::Base
  has_many :spots
  has_many :listings
  has_many :availabilities
end
