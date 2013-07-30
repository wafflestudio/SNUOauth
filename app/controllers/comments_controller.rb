class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(params[:comment].permit(:content))
    
    if @comment.save
    else
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
    else
    end
  end
end
