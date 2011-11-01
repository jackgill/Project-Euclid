class Transaction < ActiveRecord::Base
  belongs_to :spot
  belongs_to :buyer, :foreign_key => :buyer_id, :class_name => 'User'
  belongs_to :seller, :foreign_key => :seller_id, :class_name => 'User'
  
  validates :spot_id, :presence => true
  validates :buyer_id, :presence => true
  validates :seller_id, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :price, :presence => true
end
