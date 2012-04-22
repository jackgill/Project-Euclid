class TransactionsController < ApplicationController
  before_filter :require_admin, only: [ :index ]
  before_filter :find_transaction, only: [ :show, :edit, :update, :destroy, :cancel ]
  before_filter :require_owner_or_admin, only: [ :edit, :update, :destroy, :cancel ]
  
  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @transactions }
    end
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @transaction }
    end
  end

  # GET /transactions/new
  # GET /transactions/new.json
  def new
    @transaction = Transaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction }
    end
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(params[:transaction])

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render json: @transaction, status: :created, location: @transaction }
      else
        format.html { render action: "new" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /transactions/1
  # PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy

    respond_to do |format|
      format.html { message('You have successfully cancelled this transaction') }
      format.json { head :ok }
    end
  end

  def cancel
    
    respond_to do |format|    
      if @transaction.cancel
        # send notifications
        TransactionCancelledEvent.new(@transaction, @user).notify
        
        format.html { message('You have successfully cancelled this transaction') }
      else
        format.html { message('This transaction could not be cancelled') }
      end
    end
  end

  private

  def find_transaction
    @resource = @transaction = Transaction.find(params[:id])
  end
end
