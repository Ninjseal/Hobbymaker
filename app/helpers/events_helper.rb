module EventsHelper

  def format_date(date)
    date.strftime("%a, %b %d, %Y%l:%M %p %Z")
  end

  def get_location(event)
    if event.is_online?
      event.kind.titleize
    else
      event.location
    end
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
    event.is_favored_by?(current_user)
  end

end
