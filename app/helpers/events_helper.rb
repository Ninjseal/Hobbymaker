module EventsHelper

  def format_date(date)
    date.strftime("%a, %b %d, %Y %l:%M %p %Z")
  end

  def get_location(event)
    return event.kind.titleize if event.is_online?
    event.location
  end

  def detailed_location(event)
    return event.kind.titleize if event.is_online?
    if event.region.name == event.city.name
      "#{event.location}, #{event.city.name}, #{event.country.name}"
    else
      "#{event.location}, #{event.city.name}, #{event.region.name}, #{event.country.name}"
    end
  end

  def get_month(date)
    date.strftime("%b")
  end

  def get_day(event)
    if event.start_date.day < event.end_date.day && event.start_date.month == event.end_date.month && event.start_date.year == event.end_date.year
      "#{event.start_date.strftime("%d")} - #{event.end_date.strftime("%d")}"
    else
      event.start_date.strftime("%d")
    end
  end

  def get_date_interval(event)
    if event.ends_same_day?
      "#{event.start_date.strftime("%a %b %d %Y at %l:%M %P")} to #{event.end_date.strftime("%l:%M %P")}"
    else
      "#{event.start_date.strftime("%a %b %d %Y at %l:%M %P")} to #{event.end_date.strftime("%a %b %d %Y at %l:%M %P")}"
    end
  end

  def is_favored?(event)
    return false if current_user.nil?
    event.is_favored_by?(current_user)
  end

  def user_participates?(event)
    return false if current_user.nil?
    current_user.participates?(event)
  end

  def get_organizers(event)
    content_tag(:div, class: "event-organizers") do
      concat(content_tag(:span, 'Hosted By', class: "pb-2", style: "display: block; color: #2e3740;"))
      event.organizers.collect do |organizer|
        concat(content_tag(:div, class: "pb-1 pl-1", style: "display: block;") do
          concat(link_to(organizer.name, user_profile_url(organizer)))
          if current_user == organizer
            concat(content_tag(:span, '(It\'s you)', style: "color: #ED755A;"))
          else
            concat(content_tag(:span) do
              if current_user && organizer.is_followed_by?(current_user)
                concat(button_tag('Unfollow', type: 'button', class: "btn btn-unfollow btn-sm btn-outline-danger", "data-id": organizer.id))
              else
                concat(button_tag('Follow', type: 'button', class: "btn btn-follow btn-sm btn-outline-primary", "data-id": organizer.id))
              end
            end)
          end
        end)
      end
    end
  end

end
