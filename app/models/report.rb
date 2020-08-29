class Report < ApplicationRecord
  belongs_to :owner, foreign_key: :user_id, class_name: 'User'
  belongs_to :reported_item, polymorphic: true
end
