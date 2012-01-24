class RequestsController < ApplicationController
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
    return unless require_login
    
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

    respond_to do |format|
      if @request.save
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
      flash[:notice] = 'You have successfully deleted this request'
      format.html { redirect_to controller: 'home', action: 'confirmation' }
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
    # @start_date = build_date_from_params(params[:start_date])
    # @end_date = build_date_from_params(params[:end_date])
    @requests = Request.
      where(:building_id => params[:building])#.
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
    return unless require_login
    
    @spots = Spot.where(owner_id: @user.id)

    respond_to do |format|
      format.html
    end
  end

  def rent
    return unless require_login

    @request = Request.find(params[:request])
    spot_id = params[:spot]
    result = @request.fulfill(@user, params[:spot_id])
    respond_to do |format|
      if (result == true)
        format.html { redirect_to @request, notice: 'You have fulfilled this request' }
      else
        format.html { redirect_to @request, notice: 'Sorry, this fulfillment could not be processed' }
      end
    end
  end
end
