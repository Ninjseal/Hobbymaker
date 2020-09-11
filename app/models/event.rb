class Event < ApplicationRecord
  attr_accessor :country_id, :region_id

  has_and_belongs_to_many :organizers, join_table: :organizations, association_foreign_key: :user_id, class_name: 'User'
  has_and_belongs_to_many :participants, join_table: :participations, association_foreign_key: :user_id, class_name: 'User'

  has_many :favored_by_favorites, as: :favorite_item, foreign_key: :favorite_item_id, foreign_type: :favorite_item_type, class_name: 'Favorite'
  has_many :favored_by, through: :favored_by_favorites, source: :user

  has_many :reported_by_reports, as: :reported_item, foreign_key: :reported_item_id, foreign_type: :reported_item_type, class_name: 'Report'
  has_many :reported_by, through: :reported_by_reports, source: :owner

  has_and_belongs_to_many :interests

  belongs_to :city, optional: true

  enum kind: { online: 0, venue: 1 }

  validate :venue_has_location_and_city
  validates_presence_of :name, :kind, :start_date, :end_date

  has_attached_file :thumbnail, default_url: :default_thumbnail_url, url: "/system/:hash.:extension",
  hash_secret: "3973a561a452b1c72a79626a30e98e22eadb06cbbfe42ffdb0c78e71ff2bd0ca595221287b7d1d0c42a3ea9f67a6c9a66c553e690356a591b8601b68b95ded45"
  validates_attachment_content_type :thumbnail, content_type: /\Aimage\/.*\z/

  scope :online_events, -> { where(kind: Event.kinds['online']) }
  scope :venue_events, -> { where(kind: Event.kinds['venue']) }
  scope :today, -> { where(start_date: Date.today.all_day) }
  scope :this_weekend, -> { where(start_date: Date.today.sunday.yesterday.beginning_of_day..Date.today.sunday) }
  scope :weekly, -> { where(start_date: Date.today.beginning_of_day..6.days.from_now.end_of_day) }
  scope :upcoming, -> { where("start_date > ?", Time.current) }
  scope :in_progress, -> { where("start_date < :current_time AND end_date > :current_time", current_time: Time.current) }
  scope :past_events, -> { where("end_date < ?", Time.current) }

  has_rich_text :description

  def country
    self.city.region.country
  end

  def region
    self.city.region
  end

  def is_online?
    self.kind == 'online'
  end

  def is_favored_by?(user)
    Favorite.exists?(user_id: user.id, favorite_item_id: self.id, favorite_item_type: "event")
  end

  def ends_same_day?
    self.start_date.to_date == self.end_date.to_date
  end

  private

    def default_thumbnail_url
      "default-event-thumb.png"
    end

    def venue_has_location_and_city
      if self.kind == 'venue'
        self.errors.add(:location, "can't be blank") if self.location.nil?
        self.errors.add(:city, "can't be blank") if self.city_id.nil?
      end
    end

end
