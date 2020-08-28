class GroupChat < ApplicationRecord
  has_many :messages, as: :chat, dependent: :destroy
  has_and_belongs_to_many :users

  validates_presence_of :name
end
