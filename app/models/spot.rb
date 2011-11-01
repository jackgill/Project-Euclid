class Spot < ActiveRecord::Base
  belongs_to :building
  belongs_to :owner, :foreign_key => :owner_id, :class_name => 'User'
  has_many :listing
  has_many :transaction
  
  validates :building_id, :presence => true
  validates :number, :presence => true
  validates :floor, :presence => true
  validates :owner_id, :presence => true
end
