require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  setup do
    session[:building_id] = buildings(:timber_ridge).id
    session[:user_id] = users(:bob).id
    @listing = listings(:one)
  end

  test "should get index" do
    get :index
    assert_redirected_to controller: :account, action: :login
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create listing" do
    assert_difference('Listing.count') do
      post :create, listing: @listing.attributes
    end

    assert_redirected_to listing_path(assigns(:listing))
  end

  test "should show listing" do
    get :show, id: @listing.to_param
    assert_response :success
  end

  test "should get edit" do
    # Bob can request the edit page, since he owns the listing
    get :edit, id: @listing.to_param
    assert_response :success

    # Alice cannot
    session[:user_id] = users(:alice).id
    get :edit, id: @listing.to_param
    assert_redirected_to controller: :account, action: :login
  end

  test "should update listing" do
    put :update, id: @listing.to_param, listing: @listing.attributes
    assert_redirected_to listing_path(assigns(:listing))
  end

  test "should destroy listing" do
    assert_difference('Listing.count', -1) do
      delete :destroy, id: @listing.to_param
    end

    assert_redirected_to '/home/message'
  end
end
