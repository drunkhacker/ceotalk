require 'net/http'
require 'cgi'

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env["omniauth.auth"]
    @user, @created = User.with_omniauth(auth.provider, auth.uid, auth.extra.raw_info.name, auth.info.email, current_user)

    if @user.persisted?
      #@user.skip_confirmation!

      #this user is signed in
      uri = URI.parse("http://#{request.host}:8080/index.php?act=procMemberLogin")
      res = Net::HTTP.post_form(uri, {"act" => "procMemberLogin", "user_id" => @user.email, "password" => @user.encrypted_password})
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


      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = {
        "provider" =>  auth.provider,
        "uid" => auth.uid,
        "extra" => {"raw_info" => {"name" => auth.extra.raw_info.name } },
        "info" => {"email" => auth.info.email}
      }

      redirect_to new_user_registration_url
    end
  end
end
