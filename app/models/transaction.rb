require 'DateRangeValidator.rb'

class Transaction < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :spot
  belongs_to :buyer, :foreign_key => :buyer_id, :class_name => 'User'
  belongs_to :seller, :foreign_key => :seller_id, :class_name => 'User'
  belongs_to :availability
  
  validates :spot_id, :presence => true
  validates :buyer_id, :presence => true
  validates :seller_id, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :price, :presence => true
  validates_with DateRangeValidator

  def is_owner(user)
    return user.id == buyer_id || user.id == seller_id
  end

  def cancel()
    return false unless availability
    availability.restore()
    self.cancelled = true
    save()
  end
end
