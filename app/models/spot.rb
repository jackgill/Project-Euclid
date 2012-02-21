class Spot < ActiveRecord::Base
  belongs_to :building
  belongs_to :owner, :foreign_key => :owner_id, :class_name => 'User'
  has_many :listing, dependent: :destroy
  has_many :transaction, dependent: :destroy
  
  validates :building_id, :presence => true
  validates :number, :presence => true
  validates :floor, :presence => true
  validates :owner_id, :presence => true

  def is_owner(user)
    return user.id == owner_id
  end
end
