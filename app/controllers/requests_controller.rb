class RequestsController < ApplicationController
  before_filter :require_admin, only: [ :index ]
  
  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @requests }
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @request = Request.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/new
  # GET /requests/new.json
  def new
    @request = Request.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @request }
    end
  end

  # GET /requests/1/edit
  def edit
    @request = Request.find(params[:id])
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(params[:request])

    valid_dates = true
    begin
      @request.start_date = Date.strptime(params[:request][:start_date], "%m/%d/%Y")
      @request.end_date = Date.strptime(params[:request][:end_date], "%m/%d/%Y")
    rescue
      valid_dates = false
    end
    
    respond_to do |format|
      if valid_dates && @request.save
        NewRequestEvent.new(@request).notify
        
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render json: @request, status: :created, location: @request }
      else
        format.html { render action: "new" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.json
  def update
    @request = Request.find(params[:id])

    respond_to do |format|
      if @request.update_attributes(params[:request])
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { message('You have successfully deleted this request') }
      format.json { head :ok }
    end
  end

  # def search
  #   @buildings = Building.all
  #   respond_to do |format|
  #     format.html # search.html.erb
  #   end
  # end

  def results
    # @start_date = build_date_from_params(params[:start_date])
    # @end_date = build_date_from_params(params[:end_date])
    @requests = Request.
      where(:building_id => @building.id)#.
      #where("start_date <= ?", @start_date).
      #where("end_date >= ?", @end_date)

    # Load these into session so that "Fulfill" action can access them
    session[:start_date] = @start_date
    session[:end_date] = @end_date
    
    respond_to do |format|
      format.html # results.html.erb
      format.json { render json: @requests }
    end
  end

  def fulfill
    @spots = Spot.where(owner_id: @user.id)

    respond_to do |format|
      format.html
    end
  end

  def rent
    @request = Request.find(params[:request])
    spot_id = params[:spot]
    success, transaction = @request.fulfill(@user, params[:spot_id])

    msg = success ?
      'You have fulfilled this request' :
      'Sorry, this fulfillment could not be processed'

    if success
      RequestFulfilledEvent.new(transaction).notify
    end
    
    respond_to do |format|
      format.html { return message(msg) }
    end
  end
end
