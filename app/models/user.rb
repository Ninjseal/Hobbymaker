class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

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

  belongs_to :country, optional: true

  after_create :assign_default_role

  validate :password_regex

  enum gender: { male: 0, female: 1, other: 2 }

  has_attached_file :profile_photo, default_url: :default_profile_photo_url
  validates_attachment_content_type :profile_photo, content_type: /\Aimage\/.*\z/

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first
    if user.present?
      if user.uid.nil?
        if user.confirmed?
          user.update(uid: auth.uid)
        else
          user.update(uid: auth.uid, password: Devise.friendly_token[0, 20], confirmed_at: DateTime.now)
        end
      end
    else
      user = create(uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20], name: auth.info.name, confirmed_at: DateTime.now)
    end
    user.reload
  end

  def direct_chats
    TwoUsersChat.where(["user1_id = :user_id OR user2_id = :user_id", { user_id: self.id }])
  end

  def token_expired?
    self.token_expires && (self.expires_at.nil? || self.expires_at < Time.now)
  end

  private

    def assign_default_role
      self.add_role :user if self.roles.blank?
    end

    def default_profile_photo_url
      "default-profile-photo-#{self.gender.presence || 'other'}.png"
    end

    def password_regex
      return if self.password.blank? || self.password =~ /\A.(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W|_]).{7,}\Z/
      errors.add :password, 'should contain at least one lowercase character, one uppercase character, one digit and one special character.'
    end

end
