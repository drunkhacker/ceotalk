class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def me
    params[:id] = current_user.id
    show
  end
end
