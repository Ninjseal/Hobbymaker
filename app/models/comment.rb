class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :creator, class_name: "User", foreign_key: :created_by
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id

  validates_presence_of :content

end
