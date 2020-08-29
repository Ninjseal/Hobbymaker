class PollOption < ApplicationRecord
  belongs_to :poll
  has_many :votes, foreign_key: :poll_option_id, class_name: 'PollVote', dependent: :destroy

  validates_presence_of :answer
end
