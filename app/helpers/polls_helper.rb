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

end
