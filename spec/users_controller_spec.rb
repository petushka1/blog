require_relative 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'Get index' do
    before(:each) { get root_path }
    it 'User.all should be assigned to @users' do
      @users = User.all
      expect(assigns(:users)).to eq(User.all)
    end

    it 'receives response to have status ok' do
      expect(response).to have_http_status(:ok)
    end

    it ':index template was rendered' do
      expect(response).to render_template(:index)
    end
  end

  describe ':show' do
    before(:each) do
      @author = User.create(name: 'Tom', photo: 'https://url', bio: 'bio', posts_counter: 0)
      get user_path(@author)
    end

    it 'should return status ok' do
      expect(response).to have_http_status(:ok)
    end

    it ':show template was rendered' do
      expect(response).to render_template(:show)
    end

    it ':show body contains "Tom"' do
      expect(response.body).to include('Tom')
    end
  end
end
