class ProfileController < ApplicationController
  before_action :authenticate_user!

  before_action :load_record, only: [:show, :follow_user, :unfollow_user, :favorite_posts, :favorite_events]

  def show
  end

  def follow_user
    follow = Follow.new(follower_id: current_user.id, following_id: @user.id)
    if follow.save
      render partial: 'follow_button', locals: { btn_type: 'unfollow', user_id: @user.id }
    else
      render :status => 400
    end
  end

  def unfollow_user
    if Follow.where(follower_id: current_user.id, following_id: @user.id).first&.destroy
      render partial: 'follow_button', locals: { btn_type: 'follow', user_id: @user.id }
    else
      render :status => 400
    end
  end

  def report_user
    @user = User.where(id: params[:id]).first
    @report = Report.new
  end

  def favorite_posts
    
  end

  def favorite_events

  end

  private

    def load_record
      @user = User.where(id: params[:id]).first
      return not_found unless @user.present?
    end

end
