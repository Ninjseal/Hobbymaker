class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    new_session_path(User)
  end

  def after_inactive_sign_up_path_for(resource)
    new_session_path(User)
  end

  def sign_up(resource_name, resource)
    true
  end
end
