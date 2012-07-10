require 'DateRangeValidator.rb'

class Listing < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :lister, :foreign_key => :lister_id, :class_name => 'User'
  belongs_to :spot
  belongs_to :building
  has_many :availability, dependent: :destroy

  validates :lister_id, :presence => true
  validates :building_id, :presence => true
  validates :spot_id, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :ask_price, :presence => true
  validates_with DateRangeValidator
  validate :is_unique_listing

  def is_owner(user)
    return user.id == lister_id
  end

  def is_unique_listing
    listings = Listing.
      where("end_date > ?", start_date).
      where("start_date < ?", end_date).
      where("spot_id = ?", spot_id)
    
    for listing in listings
      # If the listing id is the same, it's the same listing
      # If the listing id is different, or not present, it's a duplicate
      if listing.id != self.id
        # TODO: this error message should link to the duplicate listing
        # it should also be more grammatically correct
        errors.add(:start_date, 'there is already a listing for this spot in this date range')
      end
    end
  end

  def cancel()
    update_attribute(:cancelled, true)
  end
end
