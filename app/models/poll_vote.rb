class PollVote < ApplicationRecord
  belongs_to :user
  belongs_to :option, foreign_key: :poll_option_id, class_name: 'PollOption'
  belongs_to :poll
end
