class TalksController < ApplicationController
  respond_to :html, :js

  before_filter :set_sort_categories

  def page
    ar = 
      if @current_categories.any?
        Talk.joins(:tags).where("tags.category_id IN (?)", @current_categories.map {|cat| cat.id})
      else
        Talk.all
      end

    ar = 
      if @current_sort == 'like'
        ar.order("like_count DESC")
      elsif @current_sort == 'comment'
        ar.order("comment_count DESC")
      else
        ar.order("created_at DESC")
      end

    @talks = ar.page(params[:page]).per(19)
    @is_xhr = true
  end

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
    @banner = cookies["banner2"].blank?
    @is_xhr = !!request.xhr? 

    respond_to do |format|
      format.html { render :layout => !@is_xhr}
    end
  end

  def show
    is_facebook = request.env["HTTP_USER_AGENT"].scan(/facebookexternalhit\/1\.1/) != [] # is facebook?
    if !is_facebook && !request.xhr?
      redirect_to talks_path + "/##{params[:id]}"
      return
    end

    @resource = @talk = Talk.find(params[:id])
    @commentable = @talk.becomes(Talk)
    if !is_facebook
      @talk.increase_view_count!
      logger.debug "!! view_count = #{@talk.view_count}"
    end

    @comment = Comment.new
    @comment2 = Comment.new
    @top_comments = @talk.comments.where("like_count >= 5").order("like_count DESC").limit(3)
    @comments = @talk.comments.order("created_at DESC").page(params[:comment_page]).per(5)

    @other_talks = @talk.professional.nil? ? [] : @talk.professional.talks.where("id != ?", @talk.id).order("created_at DESC").limit(5)

    respond_with(@talk) do |format|
      format.html { render :layout => (is_facebook ? "opengraph" : !request.xhr?)}
    end
  end

  def set_sort_categories
    @current_categories = if params[:cat] then params[:cat].split(",").map {|cid| Category.find(cid)} else [] end
    @current_sort = params[:sort]
  end
end
