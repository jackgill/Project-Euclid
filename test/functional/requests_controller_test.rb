require 'test_helper'

class RequestsControllerTest < ActionController::TestCase
  setup do
    session[:building_id] = buildings(:timber_ridge).id
    session[:user_id] = users(:bob).id
    @user = users(:bob)    
    @test_request = requests(:one)
  end

  test "should get index" do
    get :index
    assert_redirected_to controller: :account, action: :login
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create request" do

    # Format start/end dates
    @test_request.start_date = (@test_request.start_date).strftime("%m/%d/%Y")
    @test_request.end_date = (@test_request.end_date).strftime("%m/%d/%Y")
    
    assert_difference('Request.count') do
      post :create, request: @test_request.attributes
    end

    assert_redirected_to request_path(assigns(:request))
  end

  test "should show request" do
    get :show, id: @test_request.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @test_request.to_param
    assert_response :success
  end

  test "should update request" do
    put :update, id: @test_request.to_param, request: @test_request.attributes
    assert_redirected_to request_path(assigns(:request))
  end

  test "should destroy request" do
    assert_difference('Request.count', -1) do
      delete :destroy, id: @test_request.to_param
    end

    assert_redirected_to '/home/message'
  end
end
