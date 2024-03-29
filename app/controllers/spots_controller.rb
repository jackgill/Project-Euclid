class SpotsController < ApplicationController
  before_filter :require_admin, only: [ :index ]
  before_filter :find_spot, only: [ :show, :edit, :update, :destroy ]
  before_filter :require_owner_or_admin, only: [ :edit, :update, :destroy ]
  
  # GET /spots
  # GET /spots.json
  def index
    @spots = Spot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @spots }
    end
  end

  # GET /spots/1
  # GET /spots/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @spot }
    end
  end

  # GET /spots/new
  # GET /spots/new.json
  def new
    @spot = Spot.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @spot }
    end
  end

  # GET /spots/1/edit
  def edit
  end

  # POST /spots
  # POST /spots.json
  def create
    @spot = Spot.new(params[:spot])

    respond_to do |format|
      if @spot.save
        format.html { redirect_to @spot, notice: 'Spot was successfully created.' }
        format.json { render json: @spot, status: :created, location: @spot }
      else
        format.html { render action: "new" }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /spots/1
  # PUT /spots/1.json
  def update

    respond_to do |format|
      if @spot.update_attributes(params[:spot])
        format.html { redirect_to @spot, notice: 'Spot was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spots/1
  # DELETE /spots/1.json
  def destroy
    @spot.destroy

    respond_to do |format|
      format.html { redirect_to spots_url }
      format.json { head :ok }
    end
  end

  def yours
    if @user == nil
      session[:requested_path] = Rails.application.routes.recognize_path request.env['PATH_INFO']
      redirect_to :action => 'login', :controller => 'account'
      return
    end

    @your_spots = Spot.where(:owner_id => session[:user_id])
  end

  private

  def find_spot
    @resource = @spot = Spot.find(params[:id])
  end
end
