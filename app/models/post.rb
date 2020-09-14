class Post < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: :created_by
  has_many :comments, dependent: :destroy

  has_many :favored_by_favorites, as: :favorite_item, foreign_key: :favorite_item_id, foreign_type: :favorite_item_type, class_name: 'Favorite'
  has_many :favored_by, through: :favored_by_favorites, source: :user

  has_many :reported_by_reports, as: :reported_item, foreign_key: :reported_item_id, foreign_type: :reported_item_type, class_name: 'Report'
  has_many :reported_by, through: :reported_by_reports, source: :owner

  has_and_belongs_to_many :interests

  validates_presence_of :title

  has_attached_file :thumbnail, default_url: :default_thumbnail_url, url: "/system/:hash.:extension",
  hash_secret: "afdf5183cad5af9973413be08fd07e7ba9749d18de8f6cd15d6feee06bcc985819c0d4cf2d3d62c72d9a26bb1d6688cf6cfc1b1dfdb083886dacec5a7b1ae827"
  validates_attachment_content_type :thumbnail, content_type: /\Aimage\/.*\z/

  has_rich_text :content

  after_create :notify_interested_users_and_followers
  before_destroy :destroy_notifications

  def is_favored_by?(user)
    Favorite.exists?(user_id: user.id, favorite_item_id: self.id, favorite_item_type: "post")
  end

  def notifications
    @notifications ||= Notification.where(params: { post: self })
  end

  private

    def default_thumbnail_url
      "default-post-thumb.jpg"
    end

    def notify_interested_users_and_followers
      users = (self.interests.map { |i| i.users } | self.creator.followers).flatten.uniq - self.creator
      PostNotification.with(post: self).deliver_later(users) if users.present?
    end

    def destroy_notifications
      notifications.destroy_all
    end

end
