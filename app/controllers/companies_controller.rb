class CompaniesController < ApplicationController
  def index

  end

  def show
    @company = Company.find(params[:id])
  end
end
