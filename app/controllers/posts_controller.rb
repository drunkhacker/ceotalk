class PostsController < ApplicationController
  respond_to :json
  def wordpress
    wp = Rubypress::Client.new(host:"blog.ceomba.co.kr", username:ENV["WP_ADMIN_ID"], password:ENV["WP_ADMIN_PWD"])
    begin
      post = wp.getPost(post_id: params[:id].to_i)
      Rails.logger.debug "load post"
      render :json => {ok: true, post: post}
    rescue XMLRPC::FaultException => ex
      if ex.message == "Invalid post ID."
        #error 404
        render :json => {ok: false, error: ex.message}
      else
        #error 500
        render :json => {ok: false, error: "Internal server error"}
      end
    end
  end
end
