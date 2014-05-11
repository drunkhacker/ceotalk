class OpenQuestionsController < ApplicationController
  respond_to :html, :js
  def index
    @questions = OpenQuestion.order("created_at DESC").page(params[:page]).per(7)
    logger.debug "@questions.length = #{@questions.length}"
  end

  def show
    is_facebook = request.env["HTTP_USER_AGENT"].scan(/facebookexternalhit\/1\.1/) != [] # is facebook?
    if !is_facebook && !request.xhr?
      redirect_to open_questions_path + "/##{params[:id]}"
      return
    end

    @resource = @question = OpenQuestion.find(params[:id])
    @comment = Comment.new
    @top_comments = @question.comments.where("like_count >= 3").order("like_count DESC").limit(3)
    @comments = @question.comments.order("created_at DESC").page(params[:comment_page]).per(5)

    respond_with(@question) do |format|
      format.html { render :layout => (is_facebook ? "opengraph" : !request.xhr?)}
    end

  end
end
