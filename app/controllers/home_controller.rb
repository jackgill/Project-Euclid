class HomeController < ApplicationController
  def index
  end

  def dashboard
    @listings = Listing.where(lister_id: @user.id)
    @requests = Request.where(requester_id: @user.id)
    @transactions_buyer = Transaction.where(buyer_id: @user.id)
    @transactions_seller = Transaction.where(seller_id: @user.id)

    respond_to do |format|
      format.html
    end
  end
end
