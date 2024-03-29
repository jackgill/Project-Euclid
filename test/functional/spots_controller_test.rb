require 'test_helper'

class SpotsControllerTest < ActionController::TestCase
  setup do
    session[:building_id] = buildings(:timber_ridge).id
    session[:user_id] = users(:bob).id

    @spot = spots(:one)
  end

  test "should get index" do
    get :index
    assert_redirected_to controller: :account, action: :login
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spot" do
    assert_difference('Spot.count') do
      spot = @spot
      spot.number += 1
      post :create, spot: spot.attributes
    end

    assert_redirected_to spot_path(assigns(:spot))
  end

  test "should show spot" do
    get :show, id: @spot.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @spot.to_param
    assert_response :success
  end

  test "should update spot" do
    put :update, id: @spot.to_param, spot: @spot.attributes
    assert_redirected_to spot_path(assigns(:spot))
  end

  test "should destroy spot" do
    assert_difference('Spot.count', -1) do
      delete :destroy, id: @spot.to_param
    end

    assert_redirected_to spots_path
  end
end
