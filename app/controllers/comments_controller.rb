class CommentsController < ApplicationController
  def new
    post = Post.find(params[:post_id])
    @comment = post.comments.new
  end

  def create
    @comment = current_user.comments.new(params[:comment].permit(:post_id, :content))
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end
end
