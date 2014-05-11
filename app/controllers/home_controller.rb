class HomeController < ApplicationController
  before_filter :set_sort_categories
  def index
    @selected_contents = Talk.where(:featured => true).order("created_at DESC").limit(12)
    logger.debug "@selected_contents.count = #{@selected_contents.count}"

    # c'league 관련
    @problems = Problem.all.limit(5)
#    @cleague_best_answers = @problems.first.comments

    # experts & Corporation part
    @featured_expert = FeaturedExpert.last
    @featured_company = Company.where(:featured => true).first

    @notices = Notice.order("regdate DESC").limit(3)
    @questions = OpenQuestion.order("created_at DESC").limit(3)
  end

  def set_sort_categories
    @current_categories = if params[:cat] then params[:cat].split(",").map {|cid| Category.find(cid)} else [] end
    @current_sort = params[:sort]
  end

  # for footer
  def company_intro
    render layout: false
  end

  def agreement
    render layout: false
  end

  def privacy_policy
    render layout: false
  end

  def email_deny
    render layout: false
  end

  def map
    render layout: false
  end

  def ceomba_intro
    render layout: false
  end

  def search
    @talks = Talk.find_by_keyword(params[:term]).page(params[:page]).per(19)
    #@talks = Talk.page(params[:page]).per(19)
    #@companies = Company.find_by_keyword(params[:term]).page(params[:page]).per(19)
    #@professionals = Professional.page(params[:page]).per(1)
    @professionals = Professional.find_by_keyword(params[:term]).page(params[:page]).per(10)
  end

  def search_page
    if params[:type] == "Talk"
      #@talks = Talk.page(params[:page]).per(19)
      @talks = Talk.find_by_keyword(params[:term]).page(params[:page]).per(19)
    elsif params[:type] == "Professional"
      #@professionals = Professional.page(params[:page]).per(10)
      @professionals = Professional.find_by_keyword(params[:term]).page(params[:page]).per(10)
    end
  end

  def notice_board
    @host = request.host
    @mid = "board_bVUC93"
    @document_srl = params[:document_srl]
  end
end
