require_relative 'rails_helper'

describe User, type: :model do
    before(:each) do
        @user = described_class.create(
            name: 'Mike',
            photo: 'https://image.url',
            bio: 'Mike bio',
            posts_counter: 0
        )
    end

    it 'With valid attributes values' do
        expect(@user).to be_valid
    end

    it 'Name should not be blank' do
        @user.name = ""
        expect(@user).to_not be_valid
    end

    it 'Name should not be blank' do
        @user.posts_counter = -10
        expect(@user).to_not be_valid
    end

    it 'display three most recent records' do
        posts = []
        (1..5).each do |p|
            posts << Post.create(
                author: @user,
                title: "Post: #{j}",
                text: "This is post No#{j}"
            )
        end
        expect(@user.three_most_recent_records.count).to eq(3)
    end
end