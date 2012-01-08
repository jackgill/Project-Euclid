class Availability < ActiveRecord::Base
  belongs_to :listing
  belongs_to :building

  validates(:listing_id,
            :building_id,
            :start_date,
            :end_date,
            :presence => true)
  #TODO: validate end_date > start_date

end
