class ProfileController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  before_action :load_record, only: [:show, :follow_user, :unfollow_user]

  def show
    if @user == current_user
      render 'my_profile'
    else
      render 'show'
    end
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

  private

    def load_record
      @user = User.where(id: params[:id]).first
      return not_found unless @user.present?
    end

end
