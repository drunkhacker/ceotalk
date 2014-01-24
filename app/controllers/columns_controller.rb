class ColumnsController < ApplicationController
  respond_to :html, :js

  def index
    @columns = Column.all
  end

  def show
    @talk = Post.find(params[:id])
    @current_user = current_user || User.first
    @comment = Comment.new
    @other_talks = @talk.professional.posts.where("id != ?", @talk.id).order("created_at DESC").limit(5)

    respond_with @talk do |format|
      format.html {render :layout => !request.xhr?}
    end
  end
end
