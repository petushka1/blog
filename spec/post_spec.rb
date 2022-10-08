require_relative 'rails_helper'

describe Post, type: :model do
    before(:each) do
        @user = User.create(name: 'Test User-1', photo: 'https://testimage.url', bio: 'Test Bio Information', posts_counter: 0)
        @post = described_class.create(
            author: @user,
            title: 'Test Post',
            text: 'This is the test post',
            likes_counter: 0,
            comments_counter: 0
        )
    end

    it 'Title should not be blank' do
        @post.title = ''
        expect(@post).to_not be_valid
    end

    it 'Title should not be valid if not longer than 250 char' do
        @post.title = 'Test Post Title longer than 250 characters is not valid and will throw an error'
        expect(@post).to be_valid
    end

    it 'Title should be invalid if longer than 250 char' do
        @post.title = 'title' * 100
        expect(@post).to_not be_valid
    end

    it 'Likes and Comments counters should be invalid if not numerical' do
        @post.likes_counter = 'not numerical'
        @post.comments_counter = 'not numerical'
        expect(@post).to_not be_valid
    end

    it 'Likes and Comments counters should be numerical' do
        @post.likes_counter = 100
        @post.comments_counter = 0
        expect(@post).to be_valid
    end

    it 'display five most recent comments' do
        comments = []
        (1..10).each do |c|
            comments << Comment.create(
                author: @user,
                post: @post,
                text: "This is Comment No#{c}"
            )
        end
        five_comments = @post.five_recent_comments
        expect(five_comments.length).to eq(5)
    end

    it 'Should increase User posts_counter by 1' do
        expect(@user.posts_counter).to eq(1)
    end

end