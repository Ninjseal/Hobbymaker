module EventsHelper

  def format_date(date)
    date.strftime("%a, %b %d, %Y%l:%M %p %Z")
  end

  def get_location(event)
    event.location # Based on type of Event, get location e.g. Online or City
  end

  def get_month(date)
    date.strftime("%b")
  end

  def get_event_day(event)
    if event.start_date.day < event.end_date.day && event.start_date.month == event.end_date.month && event.start_date.year == event.end_date.year
      "#{event.start_date.strftime("%d")} - #{event.end_date.strftime("%d")}"
    else
      event.start_date.strftime("%d")
    end
  end

  def is_favored?(event)
    return false if current_user.nil?
    Favorite.exists?(user_id: current_user.id, favorite_item_id: event.id, favorite_item_type: "event")
  end

end
