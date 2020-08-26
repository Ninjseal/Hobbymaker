class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)
    @user.access_token = auth.credentials.token
    @user.token_expires = auth.credentials.expires
    @user.expires_at = Time.at(auth.credentials.expires_at.to_i)
    refresh_token = auth.credentials.refresh_token
    @user.refresh_token = refresh_token if refresh_token.present?
    @user.save

    @user.remember_me = true
    sign_in @user, event: :authentication
    redirect_to root_path
  end

  def failure
    redirect_to new_session_path(User), alert: "An error occurred when trying to login with Google. Please try again."
  end
end
