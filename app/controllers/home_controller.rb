class HomeController < ApplicationController
  def index
    @selected_contents = Talk.where(:featured => true).sort {|x, y| y.created_at <=> x.created_at}
    logger.debug "@selected_contents.count = #{@selected_contents.count}"

    # c'league 관련
    @problems = Problem.all.limit(5)
    @cleague_best_answers = @problems.first.comments

    # experts & Corporation part
    @featured_expert = FeaturedExpert.last
    @featured_company = Company.where(:featured => true).first
  end
end
