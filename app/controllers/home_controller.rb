class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.newest_first
    @trending_events = get_trending_events
    @newest_events = get_newest_events
    @newest_posts = get_newests_posts
  end

  private

    def get_trending_events
      trending_event_ids = Event.upcoming.map { |e| [e.id, e.favored_by_favorites.count] }.sort_by { |k, v| v }.reverse.take(3).to_h.keys
      Event.where(id: trending_event_ids)
    end

    def get_newest_events
      Event.upcoming.order("created_at DESC").take(3)
    end

    def get_newests_posts
      Post.order("created_at DESC").take(3)
    end

end
