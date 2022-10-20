require 'rails_helper'

RSpec.describe 'Check User Story', type: :feature do
  let(:posts) { Post.all }

  before(:all) do
    User.create(
        name: 'Tom',
        posts_counter: 0,
        bio: "Tom's Bio",
        photo: 'https://image/img.png'
      )

    (1..5).each do |i|
    Post.create(
      author: @user,
      title: "Title #{i}", text: "Text content of post # #{i}",
      likes_counter: 0,
      comments_counter: 0
    )
end

@user = User.first
@post = Post.first

end

before(:each) do
    visit user_path(@user)
  end

  describe 'User Show' do
    
    it 'I can see the user\'s username' do
        expect(page).to have_content(@user.name)
    end

    it 'I can see the profile picture for each user' do
            expect(page).to have_xpath("//img[contains(@src,'#{@user.photo}')]")
      end

      it 'I can see the number of posts the user has written' do
            expect(page).to have_css("//p", text: @post.author.posts_counter)
      end

      it 'I can see the user\'s bio' do
        expect(page).to have_text(@user.bio)
      end

      it 'should redirect to user post index page' do
        click_link 'See all posts'
        expect(current_path).to eq(user_posts_path(@user))
      end

      it 'When I click a user\'s post, it redirects me to that post\'s show page' do
        redirect_path = user_post_path(@user, @post)
        page.find("[href='#{redirect_path}']").click
        expect(current_path).to eq(redirect_path)
      end

  end
end
