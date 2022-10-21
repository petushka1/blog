class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @posts = Post
      .includes(:author)
      .where(author_id: params[:user_id])
    @author = User.find(params[:user_id])
  end

  def show
    @post = Post.where(author_id: params[:user_id], id: params[:id]).first
    @comments = Comment.where(post: @post)
  end

  def new
    post = Post.new
    respond_to do |r|
      r.html { render :new, locals: { post:, author: current_user } }
    end
  end

  def create
    post = current_user.posts.new(post_params)
    respond_to do |r|
      r.html do
        if post.save
          flash[:success] = 'Post saved successfully!'
          redirect_to user_path(current_user)
        else
          flash.now[:error] = 'Error: Post wasn\'t saved'
          render :new, status: :unprocessable_entity, locals: { post:, author: current_user }
        end
      end
    end
  end

  def destroy
    Post.find_by(destroy_params).destroy
    redirect_to user_path(current_user)
  end

  private

  def destroy_params
    {
      id: params[:id],
      author_id: current_user.id
    }
  end

  def post_params
    params
      .require(:post)
      .permit(:title, :text)
      .merge(author: current_user, comments_counter: 0, likes_counter: 0)
  end
end
