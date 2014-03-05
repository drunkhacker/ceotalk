class Users::PasswordsController < Devise::PasswordsController
  def after_sent
    @email = params[:email]
  end

  protected
  def after_sending_reset_password_instructions_path_for(resource_name)
    logger.debug params.inspect
    "/users/reset_password_sent?email=#{params[:user][:email]}"
  end
end

