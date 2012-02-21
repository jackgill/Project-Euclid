require 'test_helper'

class BuildingsControllerTest < ActionController::TestCase
  setup do
    session[:building_id] = buildings(:timber_ridge).id
    session[:user_id] = users(:bob).id
    @user = users(:bob)
    @building = buildings(:timber_ridge)
  end

  test "should get index" do
    get :index
    assert_redirected_to controller: :account, action: :login
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create building" do
    assert_difference('Building.count') do
      post :create, building: @building.attributes
    end

    assert_redirected_to building_path(assigns(:building))
  end

  test "should show building" do
    get :show, id: @building.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @building.to_param
    assert_response :success
  end

  test "should update building" do
    put :update, id: @building.to_param, building: @building.attributes
    assert_redirected_to building_path(assigns(:building))
  end

  test "should destroy building" do
    assert_difference('Building.count', -1) do
      delete :destroy, id: @building.to_param
    end

    assert_redirected_to buildings_path
  end
end
