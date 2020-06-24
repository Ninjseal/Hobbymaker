class GroupChat < ApplicationRecord
  has_many :messages, as: :chat
  has_and_belongs_to_many :users
end
