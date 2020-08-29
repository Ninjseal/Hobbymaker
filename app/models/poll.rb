class Poll < ApplicationRecord
  belongs_to :owner, foreign_key: :user_id, class_name: 'User'
  has_many :options, foreign_key: :poll_id, class_name: 'PollOption', dependent: :destroy
  has_many :votes, foreign_key: :poll_id, class_name: 'PollVote', dependent: :destroy

  validates_presence_of :question
end
