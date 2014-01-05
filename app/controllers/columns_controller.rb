class ColumnsController < ApplicationController
  def index
    @columns = Column.all
  end

  def show
    @column = Column.find(params[:id])
  end
end
