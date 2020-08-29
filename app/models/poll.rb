class Poll < ApplicationRecord
  belongs_to :owner, foreign_key: :user_id, class_name: 'User'
  has_many :options, foreign_key: :poll_id, class_name: 'PollOption', dependent: :destroy
  has_many :votes, foreign_key: :poll_id, class_name: 'PollVote', dependent: :destroy

  has_many :reported_by_reports, as: :reported_item, foreign_key: :reported_item_id, foreign_type: :reported_item_type, class_name: 'Report'
  has_many :reported_by, through: :reported_by_reports, source: :owner

  validates_presence_of :question
end
