class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  use_growlyflash

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :stripe_card_token])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :stripe_card_token])
  end
end
