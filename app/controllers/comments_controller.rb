class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create]
  respond_to :html, :js

  def index
    unless params[:comment_id].nil?
      @comment = Comment.find(params[:comment_id])
      @comment2 = Comment.new
      @r = params[:r]
      render 'index_comments'
      return
    else
      @rid = params[:resource_id].to_i
      @rtype = params[:resource_class]
      @comments = params[:resource_class].constantize.find(params[:resource_id].to_i).comments.order("created_at DESC").page(params[:page]).per(5)
    end
  end

  def create
    #logger.debug "#{params[:comment].inspect}"
    commentable_id = params[:talk_id] || params[:problem_id] || params[:open_question_id]
    commentable =
      if params[:talk_id] then 
        Talk
      elsif params[:problem_id] then
        Problem
      elsif params[:open_question_id] then
        OpenQuestion
      end

    collection_path = 
      if params[:talk_id] then 
        talks_path
      elsif params[:problem_id] then
        problems_path
      elsif params[:open_qusetion_id] then
        open_questions_path
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
