class Spot < ActiveRecord::Base
  belongs_to :building

  validates :building_id, :presence => true
  validates :number, :presence => true
  validates :floor, :presence => true
  validates :owner_id, :presence => true
end
