class City < ApplicationRecord
  belongs_to :region
  has_many :events, dependent: :destroy

  validates_presence_of :name

  scope :order_by_name, -> { order("name asc") }
end
