class Spot < ActiveRecord::Base
  belongs_to :building
  belongs_to :owner, :foreign_key => :owner_id, :class_name => 'User'
  has_many :listing, dependent: :destroy
  has_many :transaction, dependent: :destroy
  
  validates :building_id, :presence => true
  validates :number, :presence => true
  validates :floor, :presence => true
  validates :owner_id, :presence => true
  validate :is_unique_spot
  
  def is_owner(user)
    return user.id == owner_id
  end

  def is_unique_spot
    spots = Spot.
      where("floor = ?", floor).
      where("number = ?", number).
      where("building_id = ?", building_id)

    for spot in spots
      if spot.id != id
        # TODO: add support contact email
        errors.add(:error, "someone already registered this spot")
      end
    end
  end
end
