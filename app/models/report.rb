class Report < ApplicationRecord
  belongs_to :owner, foreign_key: :user_id, class_name: 'User'
  belongs_to :reported_item, polymorphic: true

  enum status: { pending: 0, approved: 1, rejected: 2 }

  enum reason: { spam: 0, inappropriate_content: 1, other: 2 }

end
