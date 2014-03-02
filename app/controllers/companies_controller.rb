class CompaniesController < ApplicationController
  respond_to :html, :js
  def index
    @indexes = %w(ㄱ ㄴ ㄷ ㄹ ㅁ ㅂ ㅅ ㅇ ㅈ ㅊ ㅋ ㅌ ㅍ ㅎ)
    offsets = %w(가 깋 나 닣 다 딯 라 맇 마 밓 바 빟 사 싷 아 잏 자 짛 차 칳 카 킿 타 팋 파 핗 하 힣)

    @name_filter = unless params[:name_filter].nil? then params[:name_filter].to_i end
    if params[:name_filter] && params[:name_filter].to_i >= 0
      idx = params[:name_filter].to_i
      @companies = Company.where("name >= ? AND name <= ?", offsets[idx*2], offsets[idx*2+1]).page(params[:page]).per(20)
    else
      @companies = Company.page(params[:page]).per(20)
    end
  end

  def show
    is_facebook = request.env["HTTP_USER_AGENT"].scan(/facebookexternalhit\/1\.1/) != [] # is facebook?
    if !is_facebook && !request.xhr?
      redirect_to companies_path + "/##{params[:id]}"
      return
    end

    @resource = @company = Company.find(params[:id])
    respond_with do |format|
      format.html { render :layout => (is_facebook ? "opengraph" : !request.xhr?)}
    end

  end
end
