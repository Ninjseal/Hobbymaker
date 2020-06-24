class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments
  has_many :posts
  has_and_belongs_to_many :interests

  has_many :followed_follows, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :followed_follows, source: :follower

  has_many :following_follows, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_follows, source: :following

  after_create :assign_default_role

  def assign_default_role
    self.add_role :user if self.roles.blank?
  end
end
