class Region < ApplicationRecord
  belongs_to :country
  has_many :cities, dependent: :destroy

  validates_presence_of :name
end
