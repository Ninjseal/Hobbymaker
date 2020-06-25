class Post < ApplicationRecord
  belongs_to :interest
  belongs_to :creator, class_name: "User", foreign_key: :created_by
  has_many :comments
  has_many :favored_by_favorites, as: :favorite_item, foreign_key: :favorite_item_id, foreign_type: :favorite_item_type, class_name: 'Favorite'
  has_many :favored_by, through: :favored_by_favorites, source: :user
end
