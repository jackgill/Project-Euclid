require 'DateRangeValidator.rb'

class Request < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :requester, :foreign_key => :requester_id, :class_name => 'User'
  belongs_to :building
  
  validates(:requester_id,
            :building_id,
            :start_date,
            :end_date,
            :bid_price,
            :presence => true)

  validates_with DateRangeValidator
  
  def fulfill(seller, spot_id)
    # delete this request
    destroy

    # create a new transaction between the buyer and the seller
    transaction = Transaction.new(
                                  spot_id: spot_id,
                                  buyer_id: requester_id,
                                  seller_id: seller.id,
                                  start_date: start_date,
                                  end_date: end_date,
                                  price: bid_price
                                  )
    return transaction.save, transaction
  end
end
