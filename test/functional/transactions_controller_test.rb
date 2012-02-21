require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  
  setup do
    session[:building_id] = buildings(:timber_ridge).id
    session[:user_id] = users(:bob).id
    @user = users(:bob)
    @transaction = transactions(:one)
  end

  test "should get index" do
    get :index
    assert_redirected_to controller: :account, action: :login
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transaction" do
    assert_difference('Transaction.count') do
      post :create, transaction: @transaction.attributes
    end

    assert_redirected_to transaction_path(assigns(:transaction))
  end

  test "should show transaction" do
    get :show, id: @transaction.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transaction.to_param
    assert_response :success
  end

  test "should update transaction" do
    put :update, id: @transaction.to_param, transaction: @transaction.attributes
    assert_redirected_to transaction_path(assigns(:transaction))
  end

  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete :destroy, id: @transaction.to_param
    end

    assert_redirected_to '/home/message'
  end
end
