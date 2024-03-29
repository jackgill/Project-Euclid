require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :listing, :foreign_key => :lister_id
  has_many :spot, :foreign_key => :owner_id, dependent: :destroy
  has_many :request, :foreign_key => :requester_id, dependent: :destroy
  has_many :transaction_as_seller, :foreign_key => :seller_id, :class_name => 'Transaction', dependent: :destroy
  has_many :transaction_as_buyer, :foreign_key => :buyer_id, :class_name => 'Transaction', dependent: :destroy
  belongs_to :building
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  
  validates_uniqueness_of :email

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  validate :password_non_blank

  @@global_salt = "euclid"

  def self.authenticate(email, clear_password)
    user = self.find_by_email(email)
    if user
      provided_password = hash_password(clear_password, user.salt)
      if provided_password != user.hashed_password
        user = nil
      end
    end

    return user
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt()
    self.hashed_password = User.hash_password(self.password, self.salt)
  end

  private

  def password_non_blank
    errors.add(:password, "Missing password") if hashed_password.blank?
  end

  def self.hash_password(clear_password, salt)
    clear_text = clear_password + @@global_salt + salt
    hashed_text = Digest::SHA1.hexdigest(clear_text)
    return hashed_text
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end
