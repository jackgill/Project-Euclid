class Request < ActiveRecord::Base
  belongs_to :requester, :foreign_key => :requester_id, :class_name => 'User'
  
  validates :requester_id, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :bid_price, :presence => true
end
