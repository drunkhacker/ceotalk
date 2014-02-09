class ProfessionalsController < ApplicationController
  respond_to :html, :js
  def index
    #@categories = ExpertCategory.all
    @professionals = Professional.all
    @indexes = %w(ㄱ ㄴ ㄷ ㄹ ㅁ ㅂ ㅅ ㅇ ㅈ ㅊ ㅋ ㅌ ㅍ ㅎ)
  end

  def show
    @professional = Professional.find(params[:id])
    @talks = @professional.talks.order("created_at DESC").limit(2)

    respond_with do |format|
      format.html { render :layout => !request.xhr? }
    end
  end
end
