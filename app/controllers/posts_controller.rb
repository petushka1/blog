class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @author = @posts ? @posts.first.author : {}
  end

  def show
    @post = Post.where(author_id: params[:user_id], id: params[:id]).first
    @comments = Comment.all
    @comments_all = []
    @comments.each do |comment|
      @comments_all << comment if comment.post_id == @post.id
    end
  end
end
