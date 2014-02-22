class TalksController < ApplicationController
  respond_to :html, :js

  before_filter :set_sort_categories

  def index
    ar = 
      if @current_categories.any?
        Talk.joins(:tags).where("tags.category_id IN (?)", @current_categories.map {|cat| cat.id})
      else
        Talk.all
      end

    ar = 
      if @current_sort == 'comment'
        ar.order("like_count DESC")
      elsif @current_sort == 'comment'
        ar.order("comment_count DESC")
      else
        ar.order("created_at DESC")
      end

    @talks = ar.page(params[:page]).per(19)
  end

  def show
    is_facebook = request.env["HTTP_USER_AGENT"].scan(/facebookexternalhit\/1\.1/) != [] # is facebook?
    if !is_facebook && !request.xhr?
      redirect_to talks_path + "/##{params[:id]}"
      return
    end

    @talk = Talk.find(params[:id])
    @current_user = current_user || User.first
    @comment = Comment.new
    @other_talks = @talk.professional.talks.where("id != ?", @talk.id).order("created_at DESC").limit(5)

    respond_with(@talk) do |format|
      format.html { render :layout => (is_facebook ? "opengraph" : !request.xhr?)}
    end
  end

  def set_sort_categories
    @current_categories = if params[:cat] then params[:cat].split(",").map {|cid| Category.find(cid)} else [] end
    @current_sort = params[:sort]
  end
end
