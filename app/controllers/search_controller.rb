class SearchController < ApplicationController

  def index
    @search_string = params.dig(:q, :search_query).to_s
    @search_type = params[:search_type].presence || "post"
    case @search_type
    when "post"
      @records = Post.ransack(ransack_post_params).result.order("id ASC")
    when "event"
      @records = Event.ransack(ransack_event_params).result.order("id ASC")
    when "user"
      @records = User.ransack(ransack_user_params).result.order("id ASC")
    end
  end

  private

    def ransack_event_params
      { name_or_location_cont: @search_string }
    end

    def ransack_post_params
      { title_cont: @search_string }
    end

    def ransack_user_params
      { name_or_email_cont: @search_string }
    end

end
