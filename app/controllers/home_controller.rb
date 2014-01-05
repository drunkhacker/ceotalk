class HomeController < ApplicationController
  def index
    @selected_contents = (Post.where(:featured => true) + Talk.where(:featured => true)).sort {|x, y| y.created_at <=> x.created_at}
    logger.debug "@selected_contents.count = #{@selected_contents.count}"
    @contents = (Post.all + Talk.all).sort {|x, y| y.created_at <=> x.created_at}

    # c'league 관련
    @problems = Problem.all.limit(5)
    @cleague_best_answers = @problems.first.comments

    # experts & Corporation part
    @featured_experts = Professional.where(:featured => true).limit(2)
  end
end
