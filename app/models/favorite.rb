class Favorite < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id', class_name: 'User'
  belongs_to :favorite_item, polymorphic: true
end
