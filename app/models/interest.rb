class Interest < ApplicationRecord
  has_many :posts
  has_and_belongs_to_many :users

  validates_presence_of :name
end
