require 'net/http'
require 'cgi'

class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)

    # at this point, this user is signed in
    uri = URI.parse("http://#{request.host}:8080/index.php?act=procMemberLogin")
    res = Net::HTTP.post_form(uri, {"act" => "procMemberLogin", "user_id" => params[:user][:email], "password" => params[:user][:password]})
    raw_cookie = res.header["Set-Cookie"]

    # get php session id
    a = raw_cookie.scan(/PHPSESSID=([^;]+);/)

    if a.any?
      session_id = a[0][0]
      logger.debug "php session id = #{session_id}"
      cookies.delete "PHPSESSID"
      cookies["PHPSESSID"] = session_id
      #cookies["PHPSESSID"] = {value: session_id, domain: ".#{request.host}"}
    end

    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def destroy
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?

    #at this point user is signed out
    uri = URI.parse("http://#{request.host}:8080/index.php?act=dispMemberLogout")
    res = Net::HTTP.get_response(uri)
    cookies["PHPSESSID"] = 'deleted'
    #cookies["PHPSESSID"] = {value: 'deleted', domain: ".#{request.host}"}
    logger.debug "logout res code = #{res.code}"

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to redirect_path }
    end
  end
end
