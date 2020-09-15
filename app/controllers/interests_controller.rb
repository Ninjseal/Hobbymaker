class InterestsController < ApplicationController

  before_action :load_record

  def show
  end

  def subscribe
    unless current_user.is_subscribed?(@interest)
      current_user.interests << @interest
      render partial: 'subscribe_button', locals: { btn_type: 'unsubscribe', interest_id: @interest.id }
    else
      render :status => 400
    end
  end

  def unsubscribe
    if current_user.is_subscribed?(@interest)
      current_user.interests.delete(@interest)
      render partial: 'subscribe_button', locals: { btn_type: 'subscribe', interest_id: @interest.id }
    else
      render :status => 400
    end
  end

  private

    def load_record
      @interest = Interest.where(id: params[:id]).first
      return not_found unless @interest.present?
    end

end
