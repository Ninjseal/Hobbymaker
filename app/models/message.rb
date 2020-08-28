class Message < ApplicationRecord
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'
  belongs_to :chat, polymorphic: true

  validates_presence_of :content
end
