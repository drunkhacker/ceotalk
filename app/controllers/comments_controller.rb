class CommentsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :js

  def create
    #logger.debug "#{params[:comment].inspect}"
    commentable_id = params[:talk_id] || params[:problem_id]
    commentable =
      if params[:talk_id] then 
        Talk
      elsif params[:problem_id] then
        Problem
      end

    collection_path = 
      if params[:talk_id] then 
        talks_path
      elsif params[:problem_id] then
        problems_path
      end

    @commentable = commentable.find(commentable_id)
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to collection_path + "/##{@commentable.id}" }
        format.js {}
      else
        logger.error @comment.errors.inspect
        format.html { redirect_to collection_path + "/##{@commentable.id}", error: "comment can't be created"}
        #format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
