class ProblemsController < ApplicationController
  respond_to :html, :js

  def index
    @problems = Problem.order("created_at DESC").page(params[:page]).per(19)
  end

  def show
    @problem = Problem.find(params[:id])
    @comment = ProblemComment.new
    @top_comments = @problem.comments.order("like_count DESC").limit(3)

    @current_user = current_user || User.first

    @other_problems = @problem.professional.problems.where("id != ?", @problem.id).order("created_at DESC").limit(5)

    respond_with(@problem) do |format|
      format.html { render :layout => !request.xhr?}
    end
  end
end
