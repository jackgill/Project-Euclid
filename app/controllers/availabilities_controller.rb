require 'exceptions'

class AvailabilitiesController < ApplicationController
  before_filter :require_admin, except: [ :search, :results, :rent ]
  skip_before_filter :require_login, only: [ :search, :results ]
  
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
    @start_date = Date.strptime(params[:start_date], "%m/%d/%Y")
    @end_date = Date.strptime(params[:end_date], "%m/%d/%Y")
    @availabilities = Availability.
      where(:building_id => params[:building]).
      where("start_date <= ?", @start_date).
      where("end_date >= ?", @end_date).
      where("taken = false")

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
    # retrieve the availability
    @availability = Availability.find(params[:availability])

    # Set up rental parameters
    start_date = session[:start_date]
    end_date = session[:end_date]
    buyer = @user
    seller = @availability.listing.lister

    # attempt to rent the spot
    begin
      respond_to do |format|
        success, transaction = @availability.rent(start_date, end_date, buyer, seller)
        if success
          ListingFulfilledEvent.new(transaction).notify
          format.html { message('Congratulations, you have successfully reserved this spot') }
          format.json { render json: @availability, status: :created, location: @listing }
        else
          format.html { message('Oh no, some one else has rented this spot whilst you were dilly-dallying') }
          format.json { render json: @availability, status: :already_taken, location: @listing }
        end
      end
    rescue Exceptions::UserFacingException => e
      message(e.to_s)
    end
  end
end
