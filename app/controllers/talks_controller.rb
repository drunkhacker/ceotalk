class TalksController < ApplicationController
  def index
    @talks = Talks.all
  end

  def show
    @talk = Talk.find(params[:id])
  end
end
