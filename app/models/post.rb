class Post < ApplicationRecord
  belongs_to :interest
  belongs_to :creator, class_name: "User", foreign_key: :created_by
  has_many :comments, dependent: :destroy

  has_many :favored_by_favorites, as: :favorite_item, foreign_key: :favorite_item_id, foreign_type: :favorite_item_type, class_name: 'Favorite'
  has_many :favored_by, through: :favored_by_favorites, source: :user

  has_many :reported_by_reports, as: :reported_item, foreign_key: :reported_item_id, foreign_type: :reported_item_type, class_name: 'Report'
  has_many :reported_by, through: :reported_by_reports, source: :owner

  validates_presence_of :title

  has_rich_text :content

  def is_favored_by?(user)
    Favorite.exists?(user_id: user.id, favorite_item_id: self.id, favorite_item_type: "post")
  end

end
