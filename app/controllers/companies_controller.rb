class CompaniesController < ApplicationController
  respond_to :html, :js
  def index
    @companies = Company.all
    @indexes = %w(ㄱ ㄴ ㄷ ㄹ ㅁ ㅂ ㅅ ㅇ ㅈ ㅊ ㅋ ㅌ ㅍ ㅎ)
  end

  def show
    is_facebook = request.env["HTTP_USER_AGENT"].scan(/facebookexternalhit\/1\.1/) != [] # is facebook?
    if !is_facebook && !request.xhr?
      redirect_to talks_path + "/##{params[:id]}"
      return
    end

    @resource = @company = Company.find(params[:id])
    respond_with do |format|
      format.html { render :layout => (is_facebook ? "opengraph" : !request.xhr?)}
    end

  end
end
