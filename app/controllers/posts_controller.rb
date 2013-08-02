class PostsController < ApplicationController
  before_filter :is_authenticated?, :only => [:new, :create, :destroy]
  before_filter :is_authorized?, :only => [:destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(params[:post].permit(:title, :content))
    
    if @post.save
      #redirect_to post_path(@post)
      redirect_to posts_path
    else
      render "new"
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
  def is_authorized?
    @post = Post.find(params[:id])
    redirect_to root_path if @post.nil? || @post.user.id != current_user.id
  end
end
