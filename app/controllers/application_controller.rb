class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_family_registered, unless: :devise_controller?

  protected

  def configure_permitted_parameters
    keys = %i[name job birthday family relation_type]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end

  def check_family_registered
    return unless user_has_family?
    flash[:error] = 'Usuário não possui Familia'
    redirect_to new_family_path
  end

  def user_has_family?
    return unless user_signed_in? && current_user.family.nil?
    return if request.path.eql?(new_family_path)
    return if request.path.eql?(families_path)
    true
  end
end
