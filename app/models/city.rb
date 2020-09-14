class City < ApplicationRecord
  belongs_to :region
  has_many :events, dependent: :destroy

  validates_presence_of :name

  scope :order_by_name, -> { order("name asc") }

  ransacker :from_country, formatter: -> (country_id) {
    ids = Region.where(country_id: country_id).map do |r|
      r.cities.pluck(:id)
    end
    ids.present? ? ids : nil
  } do |parent|
    parent.table[:id]
  end

  ransacker :from_region, formatter: -> (region_id) {
    ids = City.where(region_id: region_id).pluck(:id)
    ids.present? ? ids : nil
  } do |parent|
    parent.table[:id]
  end

end
