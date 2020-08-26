class Event < ApplicationRecord
  has_and_belongs_to_many :organizers, join_table: :organizations, association_foreign_key: :user_id, class_name: 'User'
  has_and_belongs_to_many :participants, join_table: :participations, association_foreign_key: :user_id, class_name: 'User'
  has_many :favored_by_favorites, as: :favorite_item, foreign_key: :favorite_item_id, foreign_type: :favorite_item_type, class_name: 'Favorite'
  has_many :favored_by, through: :favored_by_favorites, source: :user

  belongs_to :city, optional: true

  enum kind: { online: 0, venue: 1 }

  validate :venue_has_location_city

  has_attached_file :thumbnail, default_url: :default_thumbnail_url
  validates_attachment_content_type :thumbnail, content_type: /\Aimage\/.*\z/

  scope :online_events, -> { where(kind: Event.kinds['online']) }
  scope :venue_events, -> { where(kind: Event.kinds['venue']) }

  def is_online?
    self.kind == 'online'
  end

  def is_favored_by?(user)
    Favorite.exists?(user_id: user.id, favorite_item_id: self.id, favorite_item_type: "event")
  end

  private

    def default_thumbnail_url
      "default-event-thumb.png"
    end

    def venue_has_location_city
      if self.kind == 'venue'
        self.errors.add(:location, "cannot be blank") if self.location.nil?
        self.errors.add(:city, "cannot be blank") if self.city_id.nil?
      end
    end

end
