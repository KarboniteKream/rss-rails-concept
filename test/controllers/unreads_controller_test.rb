require 'test_helper'

class UnreadsControllerTest < ActionController::TestCase
  setup do
    @unread = unreads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unreads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unread" do
    assert_difference('Unread.count') do
      post :create, unread: { article_id: @unread.article_id, user_id: @unread.user_id }
    end

    assert_redirected_to unread_path(assigns(:unread))
  end

  test "should show unread" do
    get :show, id: @unread
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @unread
    assert_response :success
  end

  test "should update unread" do
    patch :update, id: @unread, unread: { article_id: @unread.article_id, user_id: @unread.user_id }
    assert_redirected_to unread_path(assigns(:unread))
  end

  test "should destroy unread" do
    assert_difference('Unread.count', -1) do
      delete :destroy, id: @unread
    end

    assert_redirected_to unreads_path
  end
end
