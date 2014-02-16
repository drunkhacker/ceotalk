class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def edit
    ExpertCategory.all.each do |cat|
      self.resource.interests.build(expert_category: cat) unless self.resource.has_interest? cat.id
    end
    render :edit
  end

  def new
    build_resource({})
    ExpertCategory.all.each do |cat|
      self.resource.interests.build(expert_category: cat)
    end
    respond_with self.resource
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :name, :interests_attributes => [:expert_category_id, :_destroy] ) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :name, :interests_attributes => [:expert_category_id, :_destroy]) }
  end
end
