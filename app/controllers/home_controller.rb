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
end
