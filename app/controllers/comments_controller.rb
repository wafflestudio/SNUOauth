class CommentsController < ApplicationController
  before_filter :is_authenticated?, :only => [:new, :create, :destroy]
  before_filter :is_authorized?, :only => [:destroy]

  def new
    post = Post.find(params[:post_id])
    @comment = post.comments.new
  end

  def create
    @comment = current_user.comments.new(params[:comment].permit(:post_id, :content))
    @comment.save
  end

  def destroy
    @comment.destroy
  end

  private
  def is_authorized?
    @comment = Comment.find(params[:id])
    redirect_to root_path if @comment.nil? || @comment.user.id != current_user.id
  end
end
