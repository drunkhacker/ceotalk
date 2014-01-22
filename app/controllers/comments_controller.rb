class CommentsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :html, :js

  def create
    logger.debug "#{params[:comment].inspect}"
    @talk = Talk.find(params[:talk_id])
    @comment = @talk.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to talks_path + "/##{@talk.id}" }
        format.js {}
      else
        logger.error @comment.errors.inspect
        format.html { redirect_to talks_path + "/##{@talk.id}", error: "comment can't be created"}
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
