class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  #def edit
    #Category.all.each do |cat|
      #self.resource.interests.build(category: cat) unless self.resource.has_interest? cat.id
    #end
    #render :edit
  #end

  #def new
    #build_resource({})
    #Category.all.each do |cat|
      #self.resource.interests.build(category: cat)
    #end
    #respond_with self.resource
  #end

  def create
    build_resource(sign_up_params)
    if resource.save
      (params[:categories] || {}).values.select {|h| h["selected"] == "1"}.each {|h| resource.interests.build({category_id: h["id"].to_i})}
      resource.save
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @user_categories = params[:categories].values.select {|h| h["selected"] == "1"}.map {|h| Category.find(h["id"].to_i)}
      respond_with resource
    end
  end

  def update
    # For Rails 4
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    a = account_update_params[:company_id].split(",")
    logger.debug "!!! a = #{a}"
    if a.length > 1 && a[0].to_i == -1
      name = a[1..-1].join(",")
      c = Company.new(name: name)
      if c.save
        logger.debug "!!! company saved = #{c.name}"
        account_update_params[:company_id] = c.id
      else
      end
    end

    @user = User.find(current_user.id)
    #logger.debug account_update_params.inspect!

    f = @user.update_attributes(account_update_params)

    if f
      #set categories
      new_categories = params[:categories].values.select {|h| h["selected"] == "1"}.map {|h| Category.find(h["id"].to_i)}
      @user.categories = new_categories
      logger.debug "user.categories = #{@user.categories.map{|c| c.name}.join(",")}"
      @user.save

      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      new_categories = params[:categories].values.select {|h| h["selected"] == "1"}.map {|h| Category.find(h["id"].to_i)}
      @user.categories = new_categories
      render "edit"
    end
  end

  def after_signup
    @email = params[:email]
    #logger.raise params.inspect
  end

  def check_email
    @user = User.where("email = ?", params[:email]).first
    @exist = !@user.nil?
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name, :interests_attributes => [:category_id, :_destroy] ) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :profile_photo, :password, :password_confirmation, :current_password, :name, :company_id, :position, :contact, :career, :introduction, :interests_attributes => [:category_id, :_destroy]) }
  end

  def after_update_path_for(resource)
    profile_users_path
  end

  def after_inactive_sign_up_path_for(resource)
    logger.debug "resource.unconfirmed_email = #{resource.unconfirmed_email}"
    "/users/confirmation_sent?email=#{params[:user][:email]}"
  end
end
