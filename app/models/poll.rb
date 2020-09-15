class Poll < ApplicationRecord
  belongs_to :owner, foreign_key: :user_id, class_name: 'User'
  has_many :options, foreign_key: :poll_id, class_name: 'PollOption', dependent: :destroy, inverse_of: :poll
  has_many :votes, foreign_key: :poll_id, class_name: 'PollVote', dependent: :destroy

  has_many :reported_by_reports, as: :reported_item, foreign_key: :reported_item_id, foreign_type: :reported_item_type, class_name: 'Report'
  has_many :reported_by, through: :reported_by_reports, source: :owner

  accepts_nested_attributes_for :options

  validates_presence_of :question

  after_create :notify_followers
  before_destroy :destroy_notifications

  def voted_by?(user)
    PollVote.exists?(user_id: user.id, poll_id: self.id)
  end

  def notifications
    @notifications ||= Notification.where(params: { poll: self })
  end

  private

    def notify_followers
      users = self.owner.followers - [self.owner]
      PollNotification.with(poll: self).deliver_later(users) if users.present?
    end

    def destroy_notifications
      notifications.destroy_all
    end

end
