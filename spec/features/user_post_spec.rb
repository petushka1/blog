require 'rails_helper'

RSpec.describe 'Check User Story', type: :feature do
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

  describe 'User Post Index Page' do
    before(:each) do
      visit user_posts_path(@user)
    end

    it 'I can see the user\'s profile picture' do
      expect(page).to have_xpath("//img[contains(@src,'#{@user.photo}')]")
    end

    it 'I can see the user\'s username' do
      expect(page).to have_css('//h3', text: @user.name)
    end

    it 'I can see some of the post\'s body' do
      expect(page).to have_css('//p', text: @post.text)
    end

    it 'I can see some of the post\'s body' do
      expect(page).to have_css('//p', text: 'Post text content')
    end

    it 'I can see a post\'s title.' do
      expect(page).to have_css('//h4', text: 'Post of User')
    end

    it 'I can see how many comments a post has' do
      expect(page).to have_css('//span', text: @post.comments_counter)
    end

    it 'I can see how many likes a post has' do
      expect(page).to have_text(@post.likes_counter.to_s)
    end

    it 'I can see a section for pagination if there are more posts than fit on the view' do
      expect(page).to have_button('Pagination')
    end

    it 'When I click on a post, it redirects me to that post\'s show page.' do
      expect(page).to_not have_css("[href='#{user_post_path(@user, @post)}']")
    end

    describe 'Post Comments' do
      before(:all) do
        @comment = Comment.create(
          author: @user,
          post: @post,
          text: 'Post Comment Content'
        )
      end
      it 'I can see the first comments on a post' do
        expect(page).to have_css('//li', text: "#{@comment.author.name}: #{@comment.text}")
      end
    end

    #
    #
    #
    #
    #   end
    #
    #   describe 'User post info' do
    #     before(:each) { visit(user_path(@user)) }
    #
    #     it 'I can see a post\'s title.' do
    #       expect(page).to have_css('//h2', text: 'Post of User')
    #     end
    #     it 'I can see the number of posts the user has written.' do
    #       expect(page).to have_css('//p', text: @user.posts_counter)
    #     end
    #   end
    #
    #   describe 'Post Comments' do
    #     before(:each) do
    #       visit user_posts_path(@user)
    #     end
    #
    #     before(:all) do
    #       @post = Post.first
    #
    #       @comment = Comment.create(
    #         author: @user,
    #         post: @post,
    #         text: 'Post Comment Content'
    #       )
    #     end
    #     it 'I can see the first comments on a post' do
    #       expect(page).to have_css('//h3', text: "#{@comment.author_id}#{@comment.text}")
    #     end
    #
    #     it 'I can see how many comments a post has' do
    #       expect(page).to have_css('//h3', text: @post.comments_conter)
    #     end
    #
    #     it 'I can see how many likes a post has' do
    #       expect(page).to have_text(@post.likes_counter.to_s)
    #     end
    #
    #     it 'I can see a section for pagination if there are more posts than fit on the view' do
    #       expect(page).to have_button('Pagination')
    #     end
    #
    #     it 'When I click on a post, it redirects me to that post\'s show page.' do
    #       expect(page).to_not have_css("[href='#{user_post_path(@user, @post)}']")
    #     end
    #   end
    #
    #   describe 'Post Comments' do
    #     before(:each) do
    #       visit user_post_path(@user, @post)
    #     end
    #
    #     before(:all) do
    #       @post = Post.first
    #
    #       (1..6).each do |i|
    #         Comment.create(
    #           author: @user,
    #           post: @post,
    #           text: "Post Comment Content - #{i}"
    #         )
    #       end
    #       @comment = Comment.first
    #     end
    #     it 'I can see the post\'s title' do
    #       expect(page).to have_css('//h2', text: @post.title)
    #     end
    #
    #     it 'I can see who wrote the post' do
    #       expect(page).to have_text(@post.author_id.to_s)
    #     end
    #
    #     it 'I can see how many comments it has' do
    #       expect(page).to have_css('//h3', text: @post.comments_conter)
    #     end
    #
    #     it 'I can see how many likes it has' do
    #       expect(page).to have_css('//h3', text: @post.likes_counter)
    #     end
    #
    #     it 'I can see the post body.' do
    #       expect(page).to have_css('//p', text: @post.text)
    #     end
    #
    #     it 'I can see the username of each commentor' do
    #       expect(page).to_not have_text(@post.author.to_s)
    #     end
    #
    #     it 'I can see the comment each commentor left' do
    #       expect(page).to have_css('//h3', text: @comment.text)
    #     end
  end
end
