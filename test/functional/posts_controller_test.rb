require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    
    @user = FactoryGirl.create(:user)
    @tournament = FactoryGirl.create(:tournament, :user => @user)
    @post = FactoryGirl.create(:post, :tournament => @tournament)
  end

  test "should get index" do
    get :index, tournament_id: @post.tournament_id
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    sign_in(@user)
    get :new, tournament_id: @post.tournament_id
    assert_response :success
  end

  test "should create post" do
    sign_in(@user)
    @post.destroy
    assert_difference('Post.count') do
      post :create, post: @post.attributes, tournament_id: @post.tournament_id
    end

    assert_redirected_to tournament_post_path(@post.tournament, @post)
  end

  test "should show post" do
    get :show, id: @post.id, tournament_id: @post.tournament_id
    assert_response :success
  end

  test "should get edit" do
    sign_in(@user)
    get :edit, id: @post.to_param, tournament_id: @post.tournament_id

    assert_response :success
  end

  test "should update post" do
    put :update, id: @post.to_param, post: @post.attributes, tournament_id: @post.tournament_id
    assert_redirected_to tournament_post_path(@post.tournament, @post)
  end

  test "should destroy post" do
    sign_in(@user)
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post.to_param, tournament_id: @post.tournament_id

    end

    assert_redirected_to tournament_posts_path(@post.tournament)
  end
end
