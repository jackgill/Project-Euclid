class Listing < ActiveRecord::Base
  belongs_to :lister, :foreign_key => :lister_id, :class_name => 'User'
  belongs_to :spot
  belongs_to :building
  has_many :availability, dependent: :destroy
  before_destroy :cancel_pending_transactions

  validates :lister_id, :presence => true
  validates :building_id, :presence => true
  validates :spot_id, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  #TODO: validate end_date > start_date
  validates :ask_price, :presence => true
end
