class Post < ApplicationRecord
  belongs_to :interest
  belongs_to :creator, class_name: "User", foreign_key: :created_by
  has_many :comments
end
