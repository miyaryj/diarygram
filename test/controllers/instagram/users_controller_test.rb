require 'test_helper'

class Instagram::UsersControllerTest < ActionController::TestCase
  setup do
    @instagram_user = instagram_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:instagram_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create instagram_user" do
    assert_difference('Instagram::User.count') do
      post :create, instagram_user: { instagram_user_id: @instagram_user.instagram_user_id, name: @instagram_user.name, profile_image_url: @instagram_user.profile_image_url, user_id: @instagram_user.user_id }
    end

    assert_redirected_to instagram_user_path(assigns(:instagram_user))
  end

  test "should show instagram_user" do
    get :show, id: @instagram_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @instagram_user
    assert_response :success
  end

  test "should update instagram_user" do
    patch :update, id: @instagram_user, instagram_user: { instagram_user_id: @instagram_user.instagram_user_id, name: @instagram_user.name, profile_image_url: @instagram_user.profile_image_url, user_id: @instagram_user.user_id }
    assert_redirected_to instagram_user_path(assigns(:instagram_user))
  end

  test "should destroy instagram_user" do
    assert_difference('Instagram::User.count', -1) do
      delete :destroy, id: @instagram_user
    end

    assert_redirected_to instagram_users_path
  end
end
