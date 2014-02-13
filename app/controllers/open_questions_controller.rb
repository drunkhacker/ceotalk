class OpenQuestionsController < ApplicationController
  respond_to :html, :js
  def index
    @questions = OpenQuestion.order("created_at DESC").page(params[:page]).per(7)
  end

  def show
    @question = OpenQuestion.find(params[:id])
    @current_user = current_user || User.first
    @comment = Comment.new
    @top_comments = @question.comments.order("like_count DESC").limit(3)

    respond_with(@question) do |format|
      format.html { render :layout => !request.xhr?}
    end

  end
end
