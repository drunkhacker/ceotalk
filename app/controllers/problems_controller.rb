class ProblemsController < ApplicationController
  respond_to :html, :js

  def index
    @problems = Problem.order("created_at DESC").page(params[:page]).per(19)
  end

  def show
    is_facebook = request.env["HTTP_USER_AGENT"].scan(/facebookexternalhit\/1\.1/) != [] # is facebook?

    if !is_facebook && !request.xhr?
      redirect_to talks_path + "/##{params[:id]}"
      return
    end

    @resource = @problem = Problem.find(params[:id])
    @phase = (params[:phase] || @problem.phase).to_i
    @comment = ProblemComment.new
    @top_comments = @problem.comments.order("like_count DESC").limit(3)

    @current_user = current_user || User.first

    @other_problems = @problem.professional.problems.where("id != ?", @problem.id).order("created_at DESC").limit(5)

    respond_with(@problem) do |format|
      format.html { render :layout => (is_facebook ? "opengraph" : !request.xhr?)}
    end
  end
end
