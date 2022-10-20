require 'rails_helper'

RSpec.describe 'Check User Story', type: :feature do
  before(:each) { visit(user_post_path(@user, @post)) }
  before(:all) do
    @user = User.create(
      name: 'Tom',
      posts_counter: 0,
      bio: "Tom's Bio",
      photo: 'https://image/img.png'
    )

    @post = Post.create(
      author: @user,
      title: 'Post of User', text: 'Post text content',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  describe 'User Post Show' do
    it 'I can see a post\'s title' do
      expect(page).to have_css('//span', text: "Post ##{@post.id}#{@post.title}")
    end

    it 'I can see who wrote the post' do
      expect(page).to have_css('//span', text: "by #{@post.author.name}")
    end
  end

  describe 'Post Comments and Likes' do
    before(:all) do
      (1..6).each do |i|
        Comment.create(
          author: @user,
          post: @post,
          text: "Post Comment Content - #{i}"
        )
      end

      Like.create(
        author: @user,
        post: @post
      )

      @comment = Comment.first
    end

    it 'I can see how many comments it has' do
      expect(page).to have_css('//span', text: @post.comments_counter)
    end

    it 'I can see how many likes it has' do
      expect(page).to have_css('//span', text: @post.likes_counter)
    end

    it 'I can see the post body.' do
      expect(page).to have_css('//p', text: @post.text)
    end

    it 'I can see the username of each commentor' do
      expect(page).to have_text(@post.author.name.to_s)
    end

    it 'I can see the comment each commentor left' do
      expect(page).to have_text(@comment.text.to_s)
    end
  end
end
