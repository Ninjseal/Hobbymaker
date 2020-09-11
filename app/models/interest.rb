class Interest < ApplicationRecord
  has_and_belongs_to_many :posts
  has_and_belongs_to_many :events
  has_and_belongs_to_many :users

  validates_presence_of :name
end
