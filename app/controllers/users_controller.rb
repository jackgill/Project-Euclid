class UsersController < ApplicationController
  before_filter :require_admin, only: [ :index ]
  skip_before_filter :require_login, only: [ :new, :create ]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @shown_user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @shown_user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @shown_user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @shown_user = User.new(params[:user])
    @shown_user.building_id = session[:building_id]

    respond_to do |format|
      if @shown_user.save
        format.html {
          # If this was new account creation, log in the user
          # and send them to the path they initially requested
          if @user == nil
            session[:user_id] = @shown_user.id
            flash[:notice] = "Welcome, #{@shown_user.first_name + ' ' + @shown_user.last_name}"
            if session[:requested_path]
              redirect_to session[:requested_path]
            else
              redirect_to :controller => 'spots', :action => 'yours'
            end
          else
            redirect_to( { controller: home, action: index}, { notice: 'User was successfully created.' })
          end
        }
        format.json { render json: @shown_user, status: :created, location: @shown_user }
      else
        format.html { render action: "new" }
        format.json { render json: @shown_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @shown_user = User.find(params[:id])

    respond_to do |format|
      if @shown_user.update_attributes(params[:user])
        format.html { redirect_to @shown_user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @shown_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @shown_user = User.find(params[:id])
    @shown_user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
