require_relative 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  before(:each) do
    @user = User.create(name: 'Sam', photo: 'https://url', posts_counter: 0)
    @post = Post.create(
      author: @user,
      title: 'My post',
      text: 'My post content',
      comments_counter: 0,
      likes_counter: 0
    )
    Comment.create(author: @user, post: @post, text: 'My first comment')
    Comment.create(author: @user, post: @post, text: 'My second comment')
    Comment.create(author: @user, post: @post, text: 'My third comment')
  end

  describe ':index' do
    before { get user_posts_path(@user) }

    it 'response status to be ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'render index template' do
      expect(response).to render_template(:index)
    end

    it 'body contains 0 amount of likes' do
      expect(response.body).to include('0')
    end
  end

  describe ':show' do
    before { get user_post_path(@user, @post) }

    it 'response status to be ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'render index template' do
      expect(response).to render_template(:show)
    end

    it 'body contains text' do
      expect(response.body).to include('My post content')
    end
  end
end
