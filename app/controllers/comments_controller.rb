class CommentsController < ApplicationController
	before_filter :require_user, :except => [:index, :show]

  def index
    @message = Message.find(params[:message_id])
    @comments = @message.comments
  end
  
  def show
    @message = Message.find(params[:message_id])
    @comment = Comment.find(params[:id])
  end
  
  def new
	@message = Message.find(params[:message_id])
    @comment = Comment.new
	@comment.message = @message
  end
  
  def create
    @message = Message.find(params[:message_id])
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
	@comment.message = @message
    if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to message_path(@message)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @message = Message.find(params[:message_id])
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to message_url(@comment.message_id)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Successfully deleted comment."
    redirect_to message_url(@comment.message_id)
  end
end
