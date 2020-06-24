class TwoUsersChat < ApplicationRecord
  belongs_to :first_user, foreign_key: :user1_id, class_name: 'User'
  belongs_to :second_user, foreign_key: :user2_id, class_name: 'User'
  has_many :messages, as: :chat

  def users
    User.where(id: [self.user1_id, self.user2_id])
  end

end
