class AvailabilitiesController < ApplicationController
  # GET /availabilities
  # GET /availabilities.json
  def index
    @availabilities = Availability.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @availabilities }
    end
  end

  # GET /availabilities/1
  # GET /availabilities/1.json
  def show
    @availability = Availability.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @availability }
    end
  end

  # GET /availabilities/new
  # GET /availabilities/new.json
  def new
    @availability = Availability.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @availability }
    end
  end

  # GET /availabilities/1/edit
  def edit
    @availability = Availability.find(params[:id])
  end

  # POST /availabilities
  # POST /availabilities.json
  def create
    @availability = Availability.new(params[:availability])

    respond_to do |format|
      if @availability.save
        format.html { redirect_to @availability, notice: 'Availability was successfully created.' }
        format.json { render json: @availability, status: :created, location: @availability }
      else
        format.html { render action: "new" }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /availabilities/1
  # PUT /availabilities/1.json
  def update
    @availability = Availability.find(params[:id])

    respond_to do |format|
      if @availability.update_attributes(params[:availability])
        format.html { redirect_to @availability, notice: 'Availability was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /availabilities/1
  # DELETE /availabilities/1.json
  def destroy
    @availability = Availability.find(params[:id])
    @availability.destroy

    respond_to do |format|
      format.html { redirect_to availabilities_url }
      format.json { head :ok }
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
      where("start_date <= ?", @start_date).
      where("end_date >= ?", @end_date)

    # Load these into session so that "Rent" action can access them
    session[:start_date] = @start_date
    session[:end_date] = @end_date
    
    respond_to do |format|
      format.html # results.html.erb
      format.json { render json: @availabilities }
    end
  end

  # to rent a spot
  def rent
    return unless require_login
    
    # retrieve the availability
    @availability = Availability.find(params[:availability])

    # Set up rental parameters
    start_date = session[:start_date]
    end_date = session[:end_date]
    buyer = @user
    seller = @availability.listing.lister

    # attempt to rent the spot
    respond_to do |format|
      if @availability.rent(start_date, end_date, buyer, seller)
        flash[:notice] = 'Congratulations, you have successfully reserved this spot'
        format.html { redirect_to controller: 'home', action: 'confirmation' }
        format.json { render json: @availability, status: :created, location: @listing }
      else
        # TODO: do we need a "negation" page to redirect to?
        format.html { redirect_to @availability, notice: 'Oh no, some one else has rented this spot whilst you were dilly-dallying' }
        format.json { render json: @availability, status: :already_taken, location: @listing }
      end
    end
  end
end
