class Request < ActiveRecord::Base
  belongs_to :requester, :foreign_key => :requester_id, :class_name => 'User'
  belongs_to :building
  
  validates(:requester_id,
            :building_id,
            :start_date,
            :end_date,
            :bid_price,
            :presence => true)
  #TODO: validate end_date > start_date
end
