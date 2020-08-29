module EventsHelper

  def format_date(date)
    date.strftime("%a, %b %d, %Y %l:%M %p %Z")
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

  def get_day(event)
    if event.start_date.day < event.end_date.day && event.start_date.month == event.end_date.month && event.start_date.year == event.end_date.year
      "#{event.start_date.strftime("%d")} - #{event.end_date.strftime("%d")}"
    else
      event.start_date.strftime("%d")
    end
  end

  def get_date_interval(event)
    if event.ends_same_day?
      content_tag(:div, "#{event.start_date.strftime("%a %b %d %Y at %l:%M %P")} to #{event.end_date.strftime("%l:%M %P")}", style: "display: inline-block;")
    else
      concat content_tag(:div, "#{event.start_date.strftime("%a %b %d %Y at %l:%M %P")}", style: "display: inline-block;")
      content_tag(:div, "to #{event.end_date.strftime("%a %b %d %Y at %l:%M %P")}", style: "display: block; padding-left: 0.2rem;")
    end
  end

  def is_favored?(event)
    return false if current_user.nil?
    event.is_favored_by?(current_user)
  end

  def get_organizers(event)
    content_tag(:div, class: "event-organizers") do
      concat(content_tag(:span, 'Hosted By', class: "pb-2", style: "display: block; color: #2e3740;"))
      event.organizers.collect do |organizer|
        concat(content_tag(:div, class: "pb-1 pl-1", style: "display: block;") do
          concat(link_to(organizer.name, root_path))
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
