class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :name, :gender, :birthdate, :country_id, :about])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :gender, :password, :current_password, :birthdate, :country_id, :about])
  end

  private

  def after_sign_out_path_for(resource_or_scope)
    new_session_path(User)
  end

end
