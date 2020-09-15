module InterestsHelper

  def user_is_subscribed?(interest)
    return false if current_user.nil?
    current_user.is_subscribed?(interest)
  end

end
