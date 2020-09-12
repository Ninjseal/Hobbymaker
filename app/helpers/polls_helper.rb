module PollsHelper

  def user_voted?(poll)
    return false if current_user.nil?
    current_user.has_voted?(poll)
  end

  def get_votes_percentage(option)
    total_votes = option.poll.votes.count
    return '0' if total_votes.zero?
    (option.votes.count.to_f * 100 / total_votes.to_f).round.to_s
  end

  def chart_data(poll)
    PollVote.where(poll_id: poll.id).group(:poll_option_id).count.transform_keys { |id| PollOption.where(id: id).first&.answer }.compact
  end

  def format_poll_date(date)
    date.strftime("%b %-d, %Y")
  end

  def poll_owner_details(poll)
    content_tag(:div, class: "poll-details" ) do
      concat(content_tag(:span, class: "poll-date") do
        concat(content_tag(:span, 'Asked'))
        concat(content_tag(:time, format_poll_date(poll.created_at), datetime: date_to_iso8601(poll.created_at)))
      end)
      concat(content_tag(:span, class: "poll-owner") do
        concat(content_tag(:span, 'By'))
        concat(link_to(poll.owner.name, user_profile_url(poll.owner)))
      end)
    end
  end

end
