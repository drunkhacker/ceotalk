class LikesController < ApplicationController
  before_filter :authenticate_user!
  def like
    #check likeable
    likeable_resource = 
      params[:class].constantize.where(:id => params[:id]).first

    if likeable_resource
      if likeable_resource.like(current_user)
        render :json => {ok: true, like: likeable_resource.like_count, liked: true}
      else
        render :json => {ok: true, like: likeable_resource.like_count, liked: false}
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
        render :json => {ok: true, favorite: true}
      else
        render :json => {ok: true, favorite: false}
      end
    else
      render :json => {ok: false, error: "resource not found"}
    end
  end

  def list_favorites
    @talks = current_user.favorite_talks.page(params[:talk_page]).per(3)
    @problems = current_user.favorite_problems.page(params[:talk_page]).per(3)
    #@classes = current_user.favorite_talks.page(params[:talk_page]).per(3)
    @members_favorite = current_user.favorite_members.page(params[:talk_page]).per(3)

    render '/users/favorites'
  end
end
