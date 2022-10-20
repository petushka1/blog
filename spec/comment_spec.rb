require_relative 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @user = User.create(
      name: 'Test User-1',
      photo: 'https://testimage.url',
      bio: 'Test Bio Information',
      posts_counter: 0
    )
    @post = Post.create(
      author: @user,
      title: 'Test Post',
      text: 'This is the test post',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  it 'Should increase Post comments_counter by 1' do
    Comment.create(post: @post, author: @user, text: 'This is a Test Comment')
    expect(@post.comments_counter).to eq(1)
  end
end
