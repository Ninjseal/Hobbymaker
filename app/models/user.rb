class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments
  has_many :posts
  has_many :messages
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :group_chats

  has_and_belongs_to_many :organized_events, join_table: :organizations, association_foreign_key: :event_id, class_name: 'Event'
  has_and_belongs_to_many :joined_events, join_table: :participations, association_foreign_key: :event_id, class_name: 'Event'

  has_many :favored_favorites, foreign_key: :user_id, class_name: 'Favorite'
  has_many :favorite_events, through: :favored_favorites, source: :favorite_item, source_type: 'Event'
  has_many :favorite_posts, through: :favored_favorites, source: :favorite_item, source_type: 'Post'

  has_many :followed_follows, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :followed_follows, source: :follower

  has_many :following_follows, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_follows, source: :following

  after_create :assign_default_role

  enum gender: { male: 0, female: 1, other: 2 }

  def assign_default_role
    self.add_role :user if self.roles.blank?
  end

  def direct_chats
    TwoUsersChat.where(["user1_id = :user_id OR user2_id = :user_id", { user_id: self.id }])
  end

end
