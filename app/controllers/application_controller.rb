class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:cellphone_number])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_family])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_family_kana])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_first])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_first_kana])
  end
end