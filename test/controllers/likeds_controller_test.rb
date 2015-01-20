require 'test_helper'

class LikedsControllerTest < ActionController::TestCase
  setup do
    @liked = likeds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:likeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create liked" do
    assert_difference('Liked.count') do
      post :create, liked: { article_id: @liked.article_id, user_id: @liked.user_id }
    end

    assert_redirected_to liked_path(assigns(:liked))
  end

  test "should show liked" do
    get :show, id: @liked
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @liked
    assert_response :success
  end

  test "should update liked" do
    patch :update, id: @liked, liked: { article_id: @liked.article_id, user_id: @liked.user_id }
    assert_redirected_to liked_path(assigns(:liked))
  end

  test "should destroy liked" do
    assert_difference('Liked.count', -1) do
      delete :destroy, id: @liked
    end

    assert_redirected_to likeds_path
  end
end
