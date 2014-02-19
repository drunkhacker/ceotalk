class TalksController < ApplicationController
  respond_to :html, :js

  before_filter :set_sort_categories

  def index
    #Talk.where(
      #if @current_categories.empty?
        #true
      #else 
        #true
      #end
    #)
    #if @current_sort == 'recent'

    @talks = Talk.order("created_at DESC").page(params[:page]).per(19)
  end

  def show
    @talk = Talk.find(params[:id])
    @current_user = current_user || User.first
    @comment = Comment.new
    @other_talks = @talk.professional.talks.where("id != ?", @talk.id).order("created_at DESC").limit(5)

    #logger.debug "@talk.comments.count = #{@talk.comments.count}"

    respond_with(@talk) do |format|
      format.html { render :layout => !request.xhr?}
    end
  end

  def set_sort_categories
    @current_categories = if params[:cat] then params[:cat].split(",").map {|cid| Category.find(cid)} else [] end
    @current_sort = params[:sort]
  end
end
