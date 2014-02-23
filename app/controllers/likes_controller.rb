class LikesController < ApplicationController
  before_filter :authenticate_user!
  def like
    #check likeable
    likeable_resource = 
      params[:class].constantize.where(:id => params[:id]).first

    if likeable_resource
      if likeable_resource.like(current_user)
        render :json => {ok: true, like: likeable_resource.like_count}
      else
        render :json => {ok: true, like: -1} #already liked
      end
    else
      render :json => {ok: false, error: "resource not found"}
    end
  end

  def favorite
    #check favorable
    favorable_resource = 
      params[:class].constantize.where(:id => params[:id]).first

    if favorable_resource
      if favorable_resource.favorite(current_user)
        render :json => {ok: true}
      else
        render :json => {ok: false, error: "already favorited"}
      end
    else
      render :json => {ok: false, error: "resource not found"}
    end
  end
end
