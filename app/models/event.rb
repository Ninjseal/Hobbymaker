class Event < ApplicationRecord
  has_and_belongs_to_many :organizers, join_table: :organizations, association_foreign_key: :user_id, class_name: 'User'
  has_and_belongs_to_many :participants, join_table: :participations, association_foreign_key: :user_id, class_name: 'User'
  has_many :favored_by_favorites, as: :favorite_item, foreign_key: :favorite_item_id, foreign_type: :favorite_item_type, class_name: 'Favorite'
  has_many :favored_by, through: :favored_by_favorites, source: :user

  belongs_to :city, optional: true
end
