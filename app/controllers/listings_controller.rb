class ListingsController < ApplicationController
  before_filter :require_admin, only: [ :index ]
  before_filter :find_listing, only: [ :show, :edit, :update, :destroy ]
  before_filter :require_owner_or_admin, only: [ :edit, :update, :destroy ]
  
  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listings }
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @listing }
    end
  end

  # GET /listings/new
  # GET /listings/new.json
  def new
    @listing = Listing.new

    # The spot detail page will embed these parameters into the query string for each button
    # We can transfer them to the session here in case there are form validation errors,
    # and they are needed to re-render the form
    if params[:spot] && params[:building]
      session[:spot] =  params[:spot]
      session[:building] = params[:building]
    end


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @listing }
    end
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(params[:listing])

    # Attempt to parse dates
    valid_dates = true
    begin
      @listing.start_date = Date.strptime(params[:listing][:start_date], "%m/%d/%Y")
      @listing.end_date = Date.strptime(params[:listing][:end_date], "%m/%d/%Y")
    rescue Exception => e
      valid_dates = false
      #@listing.errors.add(:start_date, 'Missing/invalid start or end date')
      @listing.errors.add(:start_date, e.message)
    end
    
    respond_to do |format|
      if valid_dates && @listing.save 

        @availability = Availability.new({
                                           listing_id: @listing.id,
                                           building_id: @listing.building_id,
                                           start_date: @listing.start_date,
                                           end_date: @listing.end_date,
                                         })
        @availability.save # TODO: handle case where save fails

        NewListingEvent.new(@listing).notify
        
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render json: @listing, status: :created, location: @listing }
      else
        format.html { render action: "new" }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /listings/1
  # PUT /listings/1.json
  def update
    # TODO: find and update the appropriate availability entries
    respond_to do |format|
      if @listing.update_attributes(params[:listing])
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy

    respond_to do |format|
      format.html { return message 'You have successfully deleted this listing' }
      format.json { head :ok }
    end
  end

  private

  def find_listing
    @resource = @listing = Listing.find(params[:id])
  end
end
