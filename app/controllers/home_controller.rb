class HomeController < ApplicationController
  skip_before_filter :require_login, only: [ :splash, :building ]
  skip_before_filter :require_building, only: [ :splash, :building ]
  
  def index
  end

  def dashboard
    @listings = Listing.where(lister_id: @user.id).where(cancelled: false)
    @requests = Request.where(requester_id: @user.id)
    @transactions_buyer = Transaction.where(buyer_id: @user.id).where(cancelled: false)
    @transactions_seller = Transaction.where(seller_id: @user.id).where(cancelled: false)

    respond_to do |format|
      format.html
    end
  end

  def message
  end

  def splash
    if @user != nil
      redirect_to controller: "home", action: "index"
    end
  end

  def building
    if request.post?
      # TODO: check that this is a valid building id
      session[:building_id] = params[:building_id]
      redirect_to session[:requested_path]
      session[:requested_path] = nil
    end
  end
end
