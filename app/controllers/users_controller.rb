class UsersController < ApplicationController
  before_filter :authenticate_user!
  def show
    @user = User.find(params[:id])
  end
  def me
    @user = current_user
    render :action => :show
  end
end
