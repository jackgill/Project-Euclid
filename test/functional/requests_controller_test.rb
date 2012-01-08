require 'test_helper'

class RequestsControllerTest < ActionController::TestCase
  setup do
    @test_request = requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requests)
  end

  test "should get new" do
    get :new
    # Currently asserting this to be a redirect since @user will be nil
    # TODO: figure out how to inject @user and test both cases
    assert_response :redirect
  end

  test "should create request" do
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

    assert_redirected_to requests_path
  end
end
