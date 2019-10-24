class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:cellphone_number])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_family])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_family_kana])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_first])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name_first_kana])

    devise_parameter_sanitizer.permit(:sign_up, keys: [:postal_code])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:prefecture])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:city])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:address])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:building])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number])

    devise_parameter_sanitizer.permit(:sign_up, keys: [:customer_id])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:card_id])
  end

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end