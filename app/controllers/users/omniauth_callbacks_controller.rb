require 'net/http'
require 'cgi'

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env["omniauth.auth"]
    @user, @created = User.with_omniauth(auth.provider, auth.uid, auth.extra.raw_info.name, auth.info.email, current_user)

    if @user.persisted?
      #@user.skip_confirmation!

      #this user is signed in
      uri = URI.parse("http://board.ceotalk.dev/index.php?act=procMemberLogin")
      res = Net::HTTP.post_form(uri, {"act" => "procMemberLogin", "user_id" => @user.email, "password" => @user.encrypted_password})
      cookie_hash = CGI::Cookie.parse(res.header["Set-Cookie"])

      cookies["PHPSESSID"] = {value: cookie_hash["PHPSESSID"], domain: ".ceotalk.dev"}
      cookies["user-agent"] = {value: cookie_hash["user-agent"], domain: ".ceotalk.dev"}

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
