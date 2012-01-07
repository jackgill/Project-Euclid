class ListingsController < ApplicationController
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

    return unless require_login


    @listing = Listing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @listing }
    end
  end

  def search
    @buildings = Building.all
    respond_to do |format|
      format.html # search.html.erb
    end
  end

  def results
    @start_date = build_date_from_params(params[:start_date])
    @end_date = build_date_from_params(params[:end_date])
    @availabilities = Availability.
      where(:building_id => params[:building]).
      where("start_date >= ?", @start_date).
      where("end_date <= ?", @end_date)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @availabilities }
    end
  end

  # GET /listings/new
  # GET /listings/new.json
  def new
    return unless require_login
    
    @listing = Listing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @listing }
    end
  end

  # GET /listings/1/edit
  def edit
    @listing = Listing.find(params[:id])
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(params[:listing])

    respond_to do |format|
      if @listing.save

        @availability = Availability.new({
                                           listing_id: @listing.id,
                                           building_id: @listing.building_id,
                                           start_date: @listing.start_date,
                                           end_date: @listing.end_date,
                                         })
        @availability.save # TODO: handle case where save fails

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
    @listing = Listing.find(params[:id])

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
    @listing = Listing.find(params[:id])
    @listing.destroy

    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { head :ok }
    end
  end

  # to rent a spot
  def rent
    # retrieve the listing
    @listing = Listing.find(params[:listing])

    # if the listing isn't already taken, take it
    if @listing.taken == false
      @listing.taken = true
    else
      @already_taken = true
    end

    # tell the user how it went
    respond_to do |format|
      if @already_taken
        format.html { redirect_to @listing, notice: 'Oh no, some one else has rented this spot whilst you were dilly-dallying' }
        format.json { render json: @listing, status: :already_taken, location: @listing }
      else
        if @listing.save
        format.html { redirect_to @listing, notice: 'Congratulations, you have successfully reserved this spot' }
          format.json { render json: @listing, status: :created, location: @listing }
        else
          format.html { redirect_to @listing, notice: 'Sorry, there was a problem with our system. Please try again later.' }
          format.json { render json: @listing.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def build_date_from_params(params)
    Date.new(params["date(1i)"].to_i, 
             params["date(2i)"].to_i, 
             params["date(3i)"].to_i)
  end
end
