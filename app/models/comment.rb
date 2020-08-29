class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :creator, class_name: "User", foreign_key: :created_by
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id

  has_many :reported_by_reports, as: :reported_item, foreign_key: :reported_item_id, foreign_type: :reported_item_type, class_name: 'Report'
  has_many :reported_by, through: :reported_by_reports, source: :owner

  validates_presence_of :content

end
