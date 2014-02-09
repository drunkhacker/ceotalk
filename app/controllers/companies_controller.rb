class CompaniesController < ApplicationController
  respond_to :html, :js
  def index
    @companies = Company.all
    @indexes = %w(ㄱ ㄴ ㄷ ㄹ ㅁ ㅂ ㅅ ㅇ ㅈ ㅊ ㅋ ㅌ ㅍ ㅎ)
  end

  def show
    @company = Company.find(params[:id])
    respond_with do |format|
      format.html { render :layout => !request.xhr? }
    end

  end
end
