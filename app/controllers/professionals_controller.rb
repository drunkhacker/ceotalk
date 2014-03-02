class ProfessionalsController < ApplicationController
  respond_to :html, :js
  def index
    @indexes = %w(ㄱ ㄴ ㄷ ㄹ ㅁ ㅂ ㅅ ㅇ ㅈ ㅊ ㅋ ㅌ ㅍ ㅎ)
    offsets = %w(가 깋 나 닣 다 딯 라 맇 마 밓 바 빟 사 싷 아 잏 자 짛 차 칳 카 킿 타 팋 파 핗 하 힣)

    @name_filter = if params[:name_filter] && params[:name_filter].length > 0 then params[:name_filter].to_i else -1 end
    logger.debug "@name_filter = #{@name_filter}"
    if @name_filter >= 0 and @name_filter < @indexes.length
      @professionals = Professional.order("created_at DESC").where("name >= ? AND name <= ?", offsets[@name_filter*2], offsets[@name_filter*2+1]).page(params[:page]).per(20)
    elsif @name_filter < 0
      @professionals = Professional.order("created_at DESC").page(params[:page]).per(20)
    else #기타
      @professionals = Professional.order("created_at DESC").where("name < ? OR name > ?", offsets.first, offsets.last).page(params[:page]).per(20)
    end
  end

  def show
    is_facebook = request.env["HTTP_USER_AGENT"].scan(/facebookexternalhit\/1\.1/) != [] # is facebook?
    if !is_facebook && !request.xhr?
      redirect_to professionals_path + "/##{params[:id]}"
      return
    end

    @commentable = @resource = @professional = Professional.find(params[:id])
    @talks = @professional.talks.order("created_at DESC").limit(2)
    @comment = Comment.new
    @comment2 = Comment.new
    @top_comments = @professional.comments.where("like_count >= 5").order("like_count DESC").limit(3)
    @comments = @professional.comments.order("created_at DESC").page(params[:comment_page]).per(5)

    respond_with do |format|
      format.html { render :layout => (is_facebook ? "opengraph" : !request.xhr?)}
    end
  end
end
