class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :name, :gender, :birthdate, :country, :city, :about])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :current_password])
    end
end
