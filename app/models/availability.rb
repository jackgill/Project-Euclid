class Availability < ActiveRecord::Base
  belongs_to :listing
  belongs_to :building

  validates :listing_id, :presence => true
  validates :building_id, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  #TODO: validate end_date > start_date

end
