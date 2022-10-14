class CommentsController < ApplicationController
  def new
    Comment.new
    respond_to do |r|
      r.html { render :new, locals: { comment: @comment } }
    end
  end

  def create
    comment = Comment.new(comment_params)
    respond_to do |r|
      r.html do
        comment.save
        redirect_to user_posts_path(current_user)
      end
    end
  end

  def comment_params
    params
      .require(:comment)
      .permit(:text)
      .merge(author: current_user, post_id: params.require(:post_id))
  end
end
