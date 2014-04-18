class OpenQuestionsController < ApplicationController
  respond_to :html, :js
  def index
    @questions = OpenQuestion.order("created_at DESC").page(params[:page]).per(7)
    logger.debug "@questions.length = #{@questions.length}"
  end

  def show
    @question = OpenQuestion.find(params[:id])
    @comment = Comment.new
    @top_comments = @question.comments.order("like_count DESC").limit(3)
    @comments = @question.comments.order("created_at DESC").page(params[:comment_page]).per(5)

    respond_with(@question) do |format|
      format.html { render :layout => !request.xhr?}
    end

  end
end
