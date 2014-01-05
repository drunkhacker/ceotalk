class ProfessionalsController < ApplicationController
  def index
    @categories = ExpertCategory.all
    @professionals = Professional.all
    @indexes = %w(ㄱ ㄴ ㄷ ㄹ ㅁ ㅂ ㅅ ㅇ ㅈ ㅊ ㅋ ㅌ ㅍ ㅎ)
  end
end
